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
require 'rails_helper'

RSpec.describe EncodingProfile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end