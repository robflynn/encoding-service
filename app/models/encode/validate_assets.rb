require 'u-case/with_activemodel_validation'

module Encode
  class ValidateAssets < Micro::Case
    attribute :task

    validates :task, kind: EncodingTask

    def call!
      return Success { { task: task } }
    end
  end
end