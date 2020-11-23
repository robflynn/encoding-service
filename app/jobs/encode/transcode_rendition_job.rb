class Encode::TranscodeRenditionJob < ApplicationJob
  queue_as :encode

  after_perform do |job|
    task = job.arguments.first[:task]
    rendition = job.arguments.first[:rendition]

    puts "Job completed running. TID: #{task.id}  RID: #{rendition.id}"

    task.with_lock do
      task.completed_renditions = task.completed_renditions + 1
      task.save!
    end

    if task.renditions_completed?
      puts "All of the renditions have completed, Asynchronously."

      Encode::CreateDashManifest.call task: task
    end
  end

  def perform(task:, rendition:)
    raise TypeError unless task.is_a? EncodingTask
    raise TypeError unless rendition.is_a? Rendition

    puts "Transcoding a rendition! TID: #{task.id}  RID: #{rendition.id}"

    asset = task.assets.first

    tmp_folder = Encode.processing_path(task)

    source_path = asset.download(to: tmp_folder)

    input_folder = File.dirname(source_path)
    filename = File.basename(source_path)

    #output_folder = Encode.ensure_path(Encode.processing_path(task).join("output", "dash", "video", "#{rendition.resolution}_#{rendition.bitrate_bps}")).to_s
    output_folder = Encode.task_rendition_temp_path(task, rendition)

    FileUtils.mkdir_p(output_folder) unless File.exists? output_folder

    # Transcode the video
    # TODO: Handle failure of TranscodeVideo
    puts "Gonna call it"
    Encode::TranscodeVideo.call(input: source_path, output_folder: output_folder, rendition: rendition)
      .on_failure { |q| puts "ERROR", q }
      .on_success {
        chunk_folder = Encode.output_path(task).join("dash", "video", "#{rendition.resolution}_#{rendition.bitrate_bps}")
        Encode.ensure_path(chunk_folder)

        Encode::ChunkFragmentedMP4.call(input: source_path, output_folder: chunk_folder)
      }

    puts "It should have called it"
  end
end
