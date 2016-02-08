class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :account_resource_mappings, :end_datedate, :dates
  	remove_column :account_resource_mappings, :start_date
  end
end
