class AddManagerIdToResources < ActiveRecord::Migration
  def change
    add_column :resources, :manager_id, :integer
  end
end
