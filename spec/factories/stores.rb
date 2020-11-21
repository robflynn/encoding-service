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

  factory :s3_store, class: 'Store::S3Store' do
    type { "Store::S3Store" }
    name { "S3 Store "}
    configuration {
      {
        base_path: 'videos',
        access_key_id: Rails.application.credentials.access_key_id,
        secret_access_key: Rails.application.credentials.secret_access_key,
        bucket: "com-thingerly-encoding-service",
        region: "us-east-1",
      }
    }
  end
end
