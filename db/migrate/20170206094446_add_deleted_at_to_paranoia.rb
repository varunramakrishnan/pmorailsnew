class AddDeletedAtToParanoia < ActiveRecord::Migration
  def change
    add_column :accounts, :deleted_at, :datetime
    add_index :accounts, :deleted_at
    add_column :attributes, :deleted_at, :datetime
    add_index :attributes, :deleted_at
    add_column :organisational_units, :deleted_at, :datetime
    add_index :organisational_units, :deleted_at
    add_column :projects, :deleted_at, :datetime
    add_index :projects, :deleted_at
    add_column :resources, :deleted_at, :datetime
    add_index :resources, :deleted_at
    add_column :roles, :deleted_at, :datetime
    add_index :roles, :deleted_at
    add_column :services, :deleted_at, :datetime
    add_index :services, :deleted_at
    add_column :skills, :deleted_at, :datetime
    add_index :skills, :deleted_at
  end
end
