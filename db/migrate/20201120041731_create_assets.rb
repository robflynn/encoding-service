class CreateAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :assets do |t|
      t.integer :task_id
      t.string :task_type
      t.integer :store_id
      t.string :file_path

      t.timestamps
    end

    add_index :assets, [:task_id, :task_type]
    add_index :assets, :store_id
  end
end
