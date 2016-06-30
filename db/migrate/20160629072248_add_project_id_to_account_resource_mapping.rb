class AddProjectIdToAccountResourceMapping < ActiveRecord::Migration
  def change
    add_column :account_resource_mappings, :project_id, :integer
  end
end
