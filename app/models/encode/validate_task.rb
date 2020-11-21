require 'u-case/with_activemodel_validation'

module Encode
  class ValidateTask < Micro::Case
    attribute :task

    validates :task, kind: EncodingTask

    def call!
      task.validating!

      # This case will handle making sure the configuration for the task makes sense.
      # Can it even be started?  Does it have a video?  Does it only have a caption track
      # and now other files? Things like that.

      # TODO: Implement `Encode::ValdateTask`
      return Success { { task: task }}
    end
  end
end