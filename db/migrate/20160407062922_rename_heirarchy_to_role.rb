class RenameHeirarchyToRole < ActiveRecord::Migration
  def change
    rename_table :heirarchies, :roles
  end
end
