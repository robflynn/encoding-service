require 'u-case/with_activemodel_validation'

module Encode
  class CreateDashManifest < Micro::Case
    attribute :task

    validates :task, kind: EncodingTask

    def call!
      manifest = Manifest::Dash.new(task: task).to_mpd

      tmppath = Encode.processing_path(task).join("manifest.created.mpd")

      File.write(tmppath, manifest)

      return Success { { filename: output } }
    end
  end
end