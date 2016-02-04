class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :employee_id
      t.string :employee_name
      t.string :role
      t.integer :heirarchy_id

      t.timestamps null: false
    end
  end
end
