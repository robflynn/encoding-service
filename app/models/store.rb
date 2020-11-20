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
require 'memoist'

class Store < ApplicationRecord
  extend Memoist

  validates :name, presence: true
  validates :type, presence: true

  validate :type_exists
  validate :valid_configuration

  def download(asset, to:)
  end

private

  def valid_configuration
    begin
      JSON.parse(configuration)
    rescue
      errors.add(:base, "Configuration must be valid json")
    end
  end

  def type_exists
    errors.add(:base, "Type `#{type}` does not exist.") unless registered_stores.include? type
  end

  def registered_stores
    Store.subclasses.map(&:name)
  end
  memoize :registered_stores
end

require_relative 'store/local_store'