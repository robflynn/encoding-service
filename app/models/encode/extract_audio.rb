require 'u-case/with_activemodel_validation'

module Encode
  class ExtractAudio < Micro::Case
    attribute :input
    attribute :output

    def call!
      extract_audio(input: input, output: output)

      return Success { { filename: output } }
    end

    def extract_audio(input:, output:)
      cmd = "ffmpeg -y -i #{input} -vn -c:a copy #{output}"

      puts "Extracting audio..."
      puts cmd

      system(cmd)
    end
  end
end