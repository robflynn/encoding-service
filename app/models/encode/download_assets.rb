require 'u-case/with_activemodel_validation'

module Encode
  class DownloadAssets < Micro::Case
    attribute :task

    validates :task, kind: EncodingTask

    def call!
      task.downloading!

      # TODO: Implement `Encode::DownloadAssets`
      return Success { { task: task }}
    end
  end
end