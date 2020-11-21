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
class EncodingProfile < ApplicationRecord
  has_many :renditions, dependent: :destroy
end
