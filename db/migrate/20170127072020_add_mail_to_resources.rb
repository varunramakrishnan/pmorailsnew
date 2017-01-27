class AddMailToResources < ActiveRecord::Migration
  def change
    add_column :resources, :mail, :string
  end
end
