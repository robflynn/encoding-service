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
    end
  end

  def perform(task:, rendition:)
    raise TypeError unless task.is_a? EncodingTask
    raise TypeError unless rendition.is_a? Rendition

    puts "Transcoding a rendition! TID: #{task.id}  RID: #{rendition.id}"

    asset = task.assets.first

    tmp_folder = Rails.root.join("tmp", "processing", "#{task.id}")
    FileUtils.mkdir_p(tmp_folder) unless File.exists? tmp_folder

    source_path = asset.download(to: tmp_folder)

    input_folder = File.dirname(source_path)
    filename = File.basename(source_path)

    output_folder = Rails.root.join("tmp", "processing", "#{task.id}", "output", "renditions", "#{rendition.id}").to_s
    FileUtils.mkdir_p(output_folder) unless File.exists? output_folder

    # Transcode the video
    # TODO: Handle failure of TranscodeVideo
    puts "Gonna call it"
    Encode::TranscodeVideo.call(input: source_path, output_folder: output_folder, rendition: rendition)
      .on_failure { |q| puts "ERROR", q }
      .on_success { puts "ffmpeg was a success" }

    puts "It should have called it"
  end

end
