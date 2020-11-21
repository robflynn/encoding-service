class CreateRenditions < ActiveRecord::Migration[6.0]
  def change
    create_table :renditions do |t|
      t.references :encoding_profile, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.integer :width
      t.integer :height
      t.decimal :fps, precision: 5, scale: 2
      t.integer :video_bitrate
      t.integer :audio_bitrate
      t.string :container,    limit: 16,  default: 'mp4'
      t.string :video_codec,  limit: 8,   default: 'h264'
      t.string :profile,      limit: 16,  default: 'main'
      t.string :audio_codec,  limit: 8,   default: 'aac'

      t.timestamps
    end
  end
end
