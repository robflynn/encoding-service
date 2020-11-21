class AddEncodingProfileToEncodingTask < ActiveRecord::Migration[6.0]
  def change
    add_reference :encoding_tasks, :profile, null: false, foreign_key: { to_table: :encoding_profiles }
  end
end
