class EncodeJob < ApplicationJob
  queue_as :default

  def perform(task:)
    # TODO: Implement `InvalidTaskType` or handle this some other way
    raise InvalidTaskType unless task.is_a? EncodingTask

    Encode::Flow.call(task: task)
    .on_success {
      task.finished!
    }
    .on_failure { |error|
      puts "The error: ", error
      task.error!
    }
  end
end
