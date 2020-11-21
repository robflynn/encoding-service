# == Schema Information
#
# Table name: encoding_tasks
#
#  id              :bigint           not null, primary key
#  name            :string
#  status          :string           default("created")
#  output_store_id :bigint           not null
#  output_path     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  profile_id      :bigint           not null
#
# Indexes
#
#  index_encoding_tasks_on_output_store_id  (output_store_id)
#  index_encoding_tasks_on_profile_id       (profile_id)
#  index_encoding_tasks_on_status           (status)
#
# Foreign Keys
#
#  fk_rails_7f0d6c5bbc  (profile_id => encoding_profiles.id)
#  fk_rails_e011257813  (output_store_id => stores.id)
#
class EncodingTask < ApplicationRecord
  enum status: {
    created: "created",
    queued: "queued",
    validating: "validating",
    downloading: "downloading",
    finished: "finished",
    error: "error"
  }

  belongs_to :output_store, class_name: 'Store'
  belongs_to :profile, class_name: 'EncodingProfile'

  validates :encoding_profile, presence: true
  validates :output_store, presence: true
end
