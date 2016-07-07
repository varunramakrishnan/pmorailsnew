class ChangeColumnToDecimal < ActiveRecord::Migration
  def change
  	change_column :account_resource_mappings, :percentage_loaded, :decimal, :precision => 10, :scale => 2
  end
end
