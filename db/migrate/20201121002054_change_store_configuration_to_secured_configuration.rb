class ChangeStoreConfigurationToSecuredConfiguration < ActiveRecord::Migration[6.0]
  def change
    rename_column :stores, :configuration, :secured_configuration
  end
end
