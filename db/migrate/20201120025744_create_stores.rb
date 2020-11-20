class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :type
      t.string :name
      t.text :configuration, default: "{}"

      t.timestamps
    end

    add_index :stores, :type
  end
end
