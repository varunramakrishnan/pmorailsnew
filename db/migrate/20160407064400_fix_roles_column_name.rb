class FixRolesColumnName < ActiveRecord::Migration
  def change
  	rename_column :roles, :heirarchy_name, :role_name
  end
end
