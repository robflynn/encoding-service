class EncodeJob < ApplicationJob
  queue_as :encode

  def perform(task)
    raise "Invalid task type" unless task.is_a? EncodingTask


  end
end
