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

    # TODO: Set codec via rendition or profile config
    video_codec = "libx264"
    bitrate = "#{rendition.video_bitrate}K"
    output_folder = Rails.root.join("tmp", "processing", "#{task.id}", "output", "renditions", "#{rendition.id}")

    FileUtils.mkdir_p(output_folder) unless File.exists? output_folder
    hls_manifest_name = "playlist.m3u8"
    hls_segment_name = "segment%d.ts"
    width = rendition.width
    height = rendition.height
    fps = rendition.fps

    cmd = <<~CMD
      ffmpeg -v warning -hide_banner -stats  -y -i #{source_path} -an -codec:v #{video_codec} -profile:v baseline -f mp4 -b:v #{bitrate} -vf scale=#{width}:#{height} -map 0 -f segment -segment_time 10 -segment_format mpegts -segment_list "#{output_folder}/#{hls_manifest_name}" -segment_list_type m3u8 "#{output_folder}/#{hls_segment_name}"
    CMD

    puts cmd
  end
end
