require 'u-case/with_activemodel_validation'

module Encode
  class ChunkFragmentedMP4 < Micro::Case
    attribute :input
    attribute :output_folder

    def call!
      chunk_rendition_fmp4(input: input, output_folder: output_folder)

      return Success { { output_folder: output_folder } }
    end

    def chunk_rendition_fmp4(input:, output_folder:)
      puts "Chunking: input: #{input}"
      puts "Output folder: #{output_folder}"

      cmd = "MP4Box -dash #{Encode::SegmentDuration.in_milliseconds} -frag #{Encode::SegmentDuration.in_milliseconds} -rap -frag-rap -out #{output_folder}/manifest -segment-name segment_ #{input}"
      puts cmd
      system(cmd)
    end
  end
end