class CreateAccountResourceMappings < ActiveRecord::Migration
  def change
    create_table :account_resource_mappings do |t|
      t.integer :resource_id
      t.integer :account_id
      t.integer :percentage_loaded
      t.date :start_date
      t.string :end_datedate
      t.string :status

      t.timestamps null: false
    end
  end
end
