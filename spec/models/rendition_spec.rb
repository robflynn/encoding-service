# == Schema Information
#
# Table name: renditions
#
#  id                  :bigint           not null, primary key
#  encoding_profile_id :bigint           not null
#  name                :string
#  description         :string
#  width               :integer
#  height              :integer
#  fps                 :decimal(5, 2)
#  video_bitrate       :integer
#  audio_bitrate       :integer
#  container           :string(16)       default("mp4")
#  video_codec         :string(8)        default("h264")
#  profile             :string(16)       default("main")
#  audio_codec         :string(8)        default("aac")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_renditions_on_encoding_profile_id  (encoding_profile_id)
#
# Foreign Keys
#
#  fk_rails_7cbf2f4080  (encoding_profile_id => encoding_profiles.id)
#
require 'rails_helper'

RSpec.describe Rendition, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
