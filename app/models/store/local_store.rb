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
    source_file = ensure_folder(Rails.root.join('tmp', 'videos'))
  end
end
