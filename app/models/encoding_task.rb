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
#
# Indexes
#
#  index_encoding_tasks_on_output_store_id  (output_store_id)
#  index_encoding_tasks_on_status           (status)
#
# Foreign Keys
#
#  fk_rails_e011257813  (output_store_id => stores.id)
#
class EncodingTask < ApplicationRecord
  belongs_to :output_store, class_name: 'Store'
end
