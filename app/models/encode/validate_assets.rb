require 'u-case/with_activemodel_validation'

module Encode
  class ValidateAssets < Micro::Case
    attribute :task

    validates :task, kind: EncodingTask

    def call!
      task.validating!

      # return Failure :invalid_asset, result: attributes(:task)

      # TODO: Implement `Encode::ValidateAssets`
      return Success { { task: task }}
    end
  end
end