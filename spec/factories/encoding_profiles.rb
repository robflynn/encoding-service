# == Schema Information
#
# Table name: encoding_profiles
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :encoding_profile do
    name { "Test Profile" }
    description { "This is a test profile." }

    trait :with_renditions do
      before(:create) do |profile|
        profile.renditions << build(:rendition, profile: profile)
      end
    end
  end
end
