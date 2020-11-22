class Encode::TranscodeRenditionJob < ApplicationJob
  queue_as :encode

  after_perform do |job|
    task = job.arguments.first[:task]
    rendition = job.arguments.first[:rendition]

    puts "Job completed running. TID: #{task.id}  RID: #{rendition.id}"

    task.with_lock do
      task.completed_renditions = task.completed_renditions + 1
      task.save!
    end

    if task.renditions_completed?
      puts "All of the renditions have completed, Asynchronously."
    end
  end

  def perform(task:, rendition:)
    raise TypeError unless task.is_a? EncodingTask
    raise TypeError unless rendition.is_a? Rendition

    puts "Transcoding a rendition! TID: #{task.id}  RID: #{rendition.id}"
  end
end
