class EncodeJob < ApplicationJob
  queue_as :encode

  def perform(task:)
    # TODO: Implement `InvalidTaskType` or handle this some other way
    raise InvalidTaskType unless task.is_a? EncodingTask

    Encode::ValidateAssets.call(task: task)
      .on_failure { |(task, error)| handle_error(task, error) }

    task.completed_renditions = 0
    task.processing!

    # TODO: Get specifically the video or audio asset here, if we handle creation that way
    asset = task.assets.first

    input_folder = Encode.input_path(task)
    input = asset.download(to: input_folder)

    output_path = Encode.output_path(task)
    output = output_path.join("primary.m4a")

    puts "Going to attemp to extract the audio"
    Encode::ExtractAudio.call(input: input, output: output)
      .on_failure { |(error)| puts "Was there an error extracking it?", error }
      .on_success { puts "audio extracted" }

    # TODO: Configurable audio bitate?
    chunk_folder = Encode.ensure_path(Encode.output_path(task).join("dash", "audio"))
    Encode::ChunkFragmentedMP4.call(input: output, output_folder: chunk_folder)

    task.renditions.each do |rendition|
      Encode::TranscodeRenditionJob.perform_later task: task, rendition: rendition
    end
  end

private

  def handle_error(task, error)
    task.error!
  end
end
