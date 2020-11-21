class Encode::TranscodeRenditionJob < ApplicationJob
  queue_as :default

  def perform(task:, rendition:)
    raise TypeError unless rendition.is_a? Rendition

    task = rendition.task

    puts "Transcoding a rendition!"
  end
end
