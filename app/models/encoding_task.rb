# == Schema Information
#
# Table name: encoding_tasks
#
#  id                   :bigint           not null, primary key
#  name                 :string
#  status               :string           default("created")
#  output_store_id      :bigint           not null
#  output_path          :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  encoding_profile_id  :bigint           not null
#  completed_renditions :integer
#
# Indexes
#
#  index_encoding_tasks_on_encoding_profile_id  (encoding_profile_id)
#  index_encoding_tasks_on_output_store_id      (output_store_id)
#  index_encoding_tasks_on_status               (status)
#
# Foreign Keys
#
#  fk_rails_87618ac928  (encoding_profile_id => encoding_profiles.id)
#  fk_rails_e011257813  (output_store_id => stores.id)
#
class EncodingTask < ApplicationRecord
  enum status: {
    created: "created",
    queued: "queued",
    validating: "validating",
    processing: "processing",
    downloading: "downloading",
    finished: "finished",
    error: "error"
  }

  belongs_to :output_store, class_name: 'Store'
  belongs_to :encoding_profile

  has_many   :assets, as: :task, dependent: :destroy
  has_many   :renditions, through: :encoding_profile

  validates :encoding_profile, presence: true
  validates :output_store, presence: true

  def renditions_completed?
    num_renditions == completed_renditions
  end

  def num_renditions
    @num_renditions ||= renditions.count
  end
end
