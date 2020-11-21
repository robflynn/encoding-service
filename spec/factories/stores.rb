# == Schema Information
#
# Table name: stores
#
#  id                    :bigint           not null, primary key
#  type                  :string
#  name                  :string
#  secured_configuration :text             default("{}")
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_stores_on_type  (type)
#
FactoryBot.define do
  factory :store do
    type { "Store::LocalStore" }
    name { "Local Store" }
    configuration { { base_path: 'test' }.to_json }
  end
end
