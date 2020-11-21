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
require 'memoist'

class Store < ApplicationRecord
  extend Memoist

  before_save :encrypt_secure_fields

  validates :name, presence: true
  validates :type, presence: true

  validate :type_exists
  #validate :valid_configuration

  def configuration
    @decrypted_configuration ||= decrypt_secure_fields
  end

  def configuration=(value)
    # If we're dealing with a string, try to parse it
    if value.is_a? String
      value = JSON.parse(value)
    end

    # TODO: Implement `InvalidConfigurationError`
    raise InvalidConfigurationError unless value.is_a? Hash

    @decrypted_configuration = value

    puts "set it: ", @decrypted_configuration
  end

  def download(asset, to:, as: nil)
    raise StoreMismatchError unless asset.store_id == self.id

    as = File.basename(asset.file_path) if as.nil?

    return self.download_file(asset.file_path, to: to, as: as)
  end

  def download_file(file_path, to:, as:)
    raise "Not Implemented"
  end

protected

  def self.secure_fields
    []
  end

  def self.default_configuration
    {}
  end

  def ensure_path(path)
    FileUtils.mkdir_p(path) unless File.exists? path
  end

private

  def decrypt_secure_fields
    store_class = self.class == Store ? self.class : self.type.constantize
    default_config = store_class.default_configuration

    return default_config unless secured_configuration.present?

    decrypted_config = default_config.merge(JSON.parse(secured_configuration))
    secure_fields = store_class.secure_fields

    secure_fields.each do |field|
      next unless decrypted_config[field.to_sym].present?

      decrypted_config[field.to_sym] = Encryption.decrypt(Base64.decode64(decrypted_config[field]))
    end

    decrypted_config
  end

  def encrypt_secure_fields
    encrypted_config = configuration.stringify_keys

    puts "The unencrypted", encrypted_config

    secure_fields = self.type.constantize.secure_fields

    secure_fields.each do |field|
      puts "Checking #{field}"
      next unless encrypted_config[field].present?

      puts "Securing field: #{field}"

      encrypted_value = Base64.encode64(Encryption.encrypt(encrypted_config[field]))

      encrypted_config[field] = encrypted_value
    end

    self.secured_configuration = encrypted_config.to_json
  end

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
