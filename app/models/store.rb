# == Schema Information
#
# Table name: stores
#
#  id            :bigint           not null, primary key
#  type          :string
#  name          :string
#  configuration :text             default("{}")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_stores_on_type  (type)
#
class Store < ApplicationRecord
  validates :name, presence: true

  def download(asset, to:)
  end
end
