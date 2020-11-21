class AddEncodingProfileToEncodingTask < ActiveRecord::Migration[6.0]
  def change
    add_reference :encoding_tasks, :encoding_profile, null: false, foreign_key: true
  end
end
