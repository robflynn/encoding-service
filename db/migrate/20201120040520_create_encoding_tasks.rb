class CreateEncodingTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :encoding_tasks do |t|
      t.string :name
      t.string :status, default: "created"
      t.references :output_store, null: false, foreign_key: { to_table: 'stores' }
      t.string :output_path

      t.timestamps
    end

    add_index :encoding_tasks, :status
  end
end
