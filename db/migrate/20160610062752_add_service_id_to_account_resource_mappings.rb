class AddServiceIdToAccountResourceMappings < ActiveRecord::Migration
  def change
    add_column :account_resource_mappings, :service_id, :integer
  end
end
