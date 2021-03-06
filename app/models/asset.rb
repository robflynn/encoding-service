# == Schema Information
#
# Table name: assets
#
#  id         :bigint           not null, primary key
#  task_id    :integer
#  task_type  :string
#  store_id   :integer
#  file_path  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_assets_on_store_id               (store_id)
#  index_assets_on_task_id_and_task_type  (task_id,task_type)
#
class Asset < ApplicationRecord
  belongs_to :task, polymorphic: true
  belongs_to :store

  def download(to:, as: nil)
    self.store.download(self, to: to, as: as)
  end
end
