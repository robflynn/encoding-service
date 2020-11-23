# TODO: I don't like calling `ensure_path` this much. Probably need to rethink the way path stuff works.
module Encode
  def self.processing_path(task)
    Encode.ensure_path(Rails.root.join("tmp", "processing", "#{task.id}"))
  end

  def self.input_path(task)
    Encode.ensure_path(processing_path(task).join("input"))
  end

  def self.output_path(task)
    Encode.ensure_path(processing_path(task).join("output"))
  end

  def self.ensure_path(path)
    FileUtils.mkdir_p(path) unless File.exists? path

    Pathname.new(path)
  end

  def self.task_rendition_temp_path(task, rendition)
    Encode.ensure_path(output_path(task).join("renditions", "#{rendition.id}"))
  end

  SegmentDuration = 2.seconds
end
