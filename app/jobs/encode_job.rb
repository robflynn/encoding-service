class EncodeJob < ApplicationJob
  queue_as :encode

  def perform(task:)
    # TODO: Implement `InvalidTaskType` or handle this some other way
    raise InvalidTaskType unless task.is_a? EncodingTask

    Encode::ValidateAssets.call(task: task)
      .on_failure { |(task, error)| handle_error(task, error) }

    Encode::DownloadAssets.call(task: task)
      .on_failure { |(task, error)| handle_error(task, error) }


  end

private

  def handle_error(task, error)
    task.error!
  end
end
