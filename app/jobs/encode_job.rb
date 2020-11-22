class EncodeJob < ApplicationJob
  queue_as :encode

  def perform(task:)
    # TODO: Implement `InvalidTaskType` or handle this some other way
    raise InvalidTaskType unless task.is_a? EncodingTask

    Encode::ValidateAssets.call(task: task)
      .on_failure { |(task, error)| handle_error(task, error) }

    task.completed_renditions = 0
    task.processing!

    task.renditions.each do |rendition|
      Encode::TranscodeRenditionJob.perform_later task: task, rendition: rendition
    end
  end

private

  def handle_error(task, error)
    task.error!
  end
end
