class AddRoleCodetoRoles < ActiveRecord::Migration
  def change
  	 add_column :roles, :role_code, :string
  end
end
