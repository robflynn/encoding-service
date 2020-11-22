require 'u-case/with_activemodel_validation'

module Encode
  class TranscodeVideo < Micro::Case
    PROGRESS_REGEX = /frame=(.*?) time=(?<time>\d{2}:\d{2}:\d{2}.\d+)/
    TIME_REGEX = /^(?<hours>\d{2})[:,;](?<minutes>\d{2})[:,;](?<seconds>\d{2})\.(?<fractional_seconds>\d{2})$/

    attribute :input
    attribute :output_folder
    attribute :rendition

    validates :rendition, kind: Rendition

    def call!
      # TODO: Track rendition status?
#        ffmpeg -v warning -hide_banner -stats  -y -i #{input} -an -codec:v #{video_codec} -profile:v baseline -f mp4 -b:v #{bitrate} -vf scale=#{width}:#{height} -map 0 -f segment -segment_time 10 -segment_format mpegts -segment_list "#{output_folder}/#{hls_manifest_name}" -segment_list_type m3u8 "#{output_folder}/#{hls_segment_name}"

      codec = ffmpeg_codec(rendition.video_codec)
      codec_options = "-profile:v #{rendition.profile} -f #{rendition.container}"

      segment_duration = 10.seconds
      segment_size = (segment_duration * rendition.fps).round

      bitrate_options = "-b:v #{rendition.video_bitrate}K"

      video_options = [
        '-movflags frag_keyframe+empty_moov+default_base_moof',
        "-x264opts rc-lookahead=#{segment_size}"
      ].join(' ')

      resolution = "#{rendition.width}x#{rendition.height}"

      output_file = File.join(output_folder, "file.#{rendition.container}")

      cmd = <<~CMD
        ffmpeg -y -i #{input} -strict experimental -an -codec:v #{codec} #{codec_options} #{video_options} -s #{resolution} #{bitrate_options} #{output_file}
      CMD

      duration = get_duration(input)

      puts cmd

      progress = 0
      updater = 0
      steps = 10

      Open3.popen3(cmd) do |stdin, stdout, stderr|
        stderr.each("\r") do |line|
          next unless match = line.match(PROGRESS_REGEX)

          current_time = match[:time]

          pieces = current_time.match(TIME_REGEX)

          seconds = pieces[:hours].to_i * 60 * 60
          seconds = seconds + pieces[:minutes].to_i * 60
          seconds = seconds + pieces[:seconds].to_i
          seconds = seconds + (pieces[:fractional_seconds].to_i / 100.0)

          progress = ((seconds / duration) * 100).round

          if updater % steps == 0
            #task.update(progress: progress)
            puts "Progress: #{progress}%"
          end

          updater = updater + 1
        end
      end

      #task.update(progress: progress)
      puts "Progress: #{progress}%"

      return Success { { rendition: rendition }}
    end

    def ffmpeg_codec(codec)
      case codec.to_s
      when "h264"
        "libx264"
      end
    end

    def get_duration(input_filepath)
      cmd = <<~CMD
        ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 #{input_filepath}
      CMD

      data = `#{cmd}`

      data.to_f
    end
  end
end