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
FactoryBot.define do
  factory :encoding_task do
    name { "Sample Encode Task" }

    trait :with_s3_store do
      output_store { build(:s3_store) }
    end

    trait :with_local_store do
      output_store { build(:local_store) }
    end

    trait :with_test_profile do
      encoding_profile { build(:encoding_profile, :with_renditions) }
    end

    trait :with_test_assets do
      assets {
        [
          build(:video_asset)
        ]
      }
    end

    factory :encoding_task_full, class: "EncodingTask" do
      name { "Sample Encode Task" }
      with_s3_store
      with_test_profile
      with_test_assets
    end

    after(:build) do |task|
      task.assets.map { |a| a.task = task }
      task.assets.map { |a| a.store = task.output_store }
    end
  end
end
