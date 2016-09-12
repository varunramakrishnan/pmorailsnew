class AddColumnToServices < ActiveRecord::Migration
  def change
  	add_column :account_service_mappings, :comments, :text
  end
end
