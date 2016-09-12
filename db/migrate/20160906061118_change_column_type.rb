class ChangeColumnType < ActiveRecord::Migration
  def change
  	change_column :account_service_mappings, :actual_usd_value, :decimal, :precision => 20,:scale => 2
  	change_column :account_service_mappings, :anticipated_usd_value, :decimal,:precision => 20, :scale => 2
  	change_column :account_service_mappings, :actual_value, :decimal, :precision => 20,:scale => 2
  	change_column :account_service_mappings, :anticipated_value, :decimal, :precision => 20,:scale => 2
  end
end
