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
class Store::LocalStore < Store
  def download_file(file_path, to:, as:)
    source_file = local_storage_path.join(file_path)

    target_folder = ensure_path(to)
    target_path = Pathname.new(to.to_s).join(as).to_s

    FileUtils.cp(source_file, target_path)

    return target_path
  end

  def upload_file(file_path, to:, as:)
    # TODO: Implement `FileMissingError`
    #raise FileMissingError unless File.exist? file_path

    target_folder = to.to_s
    target_path = Pathname.new(to).join(as).to_s

    faux_upload_path = local_storage_path.join(target_path)

    Encode.ensure_path(File.dirname(faux_upload_path))

    puts "Faux uploading from #{file_path} to #{faux_upload_path}"

    FileUtils.cp(file_path, faux_upload_path)
  end


  def base_path
    configuration[:base_path]
  end

  def local_storage_path
    Encode.ensure_path(Rails.root.join("tmp", "local_store"))
  end
end

def self.default_configuration
  {
    access_key_id: nil,
    secret_access_key: nil,
    region: Region::US_EAST_1,
    base_path: ''
  }
end