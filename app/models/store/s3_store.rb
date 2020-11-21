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
class Store::S3Store < Store

  class Region
    US_EAST_1 = 'us-east-1'
  end

  def bucket_name
    configuration[:bucket]
  end

  def access_key_id
    configuration[:access_key_id]
  end

  def region
    configuration[:region]
  end

  def download_file(file_path, to:, as:)
    target_folder = ensure_path(to)
    target_path = to.to_s

    response = client.get_object bucket: bucket_name,
                                 key: file_path,
                                 response_target: target_path

    return Pathname.new(self.base_path).join(to, as).to_s.gsub(/^\//, //)
  end

protected

  def self.default_configuration
    {
      access_key_id: nil,
      secret_access_key: nil,
      region: Region::US_EAST_1
    }
  end

private

  def secret_access_key
    configuration[:secret_access_key]
  end

  def client
    # TODO: Add `region` `Store::S3Store` configuration
    region = Region::US_EAST_1

    puts region, access_key_id, secret_access_key

    Aws::S3::Client.new(
      region: region,
      access_key_id: access_key_id,
      secret_access_key: secret_access_key
    )
  end
  memoize :client
end
