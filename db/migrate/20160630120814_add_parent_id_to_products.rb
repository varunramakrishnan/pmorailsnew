class AddParentIdToProducts < ActiveRecord::Migration
  def change
  	add_column :projects, :parent_id, :integer
  	add_column :projects, :version, :integer
  	add_column :projects, :start_date, :string
  	add_column :projects, :end_date, :string
  end
end
