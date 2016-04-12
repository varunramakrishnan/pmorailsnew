class AddHeirarchyIdToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :heirarchy_id, :integer
  end
end
