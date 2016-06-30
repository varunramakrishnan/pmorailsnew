class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_name
      t.string :project_code
      t.integer :account_id
      t.integer :service_id

      t.timestamps null: false
    end
  end
end
