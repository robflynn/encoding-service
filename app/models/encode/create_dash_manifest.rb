require 'u-case/with_activemodel_validation'

module Encode
  class CreateDashManifest < Micro::Case
    attribute :task

    validates :task, kind: EncodingTask

    def call!
      generate_manifest

      return Success { { filename: output } }
    end

    def generate_manifest

    end
  end
end