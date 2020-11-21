class AddCompletedRenditionsToEncodingTask < ActiveRecord::Migration[6.0]
  def change
    add_column :encoding_tasks, :completed_renditions, :integer, defaut: 0
  end
end
