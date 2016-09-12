class AddCreatedByToAccountServiceMappings < ActiveRecord::Migration
  def change
    add_column :projects, :createdBy, :string
    add_column :projects, :modifiedBy, :string
  end
end
