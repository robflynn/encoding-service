require 'u-case/with_activemodel_validation'

module Encode
  class TranscodeVideo < Micro::Case
    attribute :input
    attribute :output_folder
    attribute :rendition

    validates :rendition, kind: Rendition
    validates :input, kind: String
    validates :output_folder, kind: String

    def call!
      # TODO: Track rendition status?

      # TODO: Set codec via rendition or profile config
      video_codec = "libx264"
      bitrate = "#{rendition.video_bitrate}K"

      hls_manifest_name = "playlist.m3u8"
      hls_segment_name = "segment%d.ts"
      width = rendition.width
      height = rendition.height
      fps = rendition.fps

      cmd = <<~CMD
        ffmpeg -v warning -hide_banner -stats  -y -i #{input} -an -codec:v #{video_codec} -profile:v baseline -f mp4 -b:v #{bitrate} -vf scale=#{width}:#{height} -map 0 -f segment -segment_time 10 -segment_format mpegts -segment_list "#{output_folder}/#{hls_manifest_name}" -segment_list_type m3u8 "#{output_folder}/#{hls_segment_name}"
      CMD

      puts cmd

      return Success { { rendition: rendition }}
    end
  end
end