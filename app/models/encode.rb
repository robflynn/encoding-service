module Encode
  def self.processing_path(task)
    Rails.root.join("tmp", "processing", "#{task.id}")
  end

  def self.input_path(task)
    processing_path(task).join("input")
  end

  def self.output_path(task)
    processing_path(task).join("output")
  end
end
