class CreateAccountServiceMappings < ActiveRecord::Migration
  def change
    create_table :account_service_mappings do |t|
      t.integer :account_id
      t.integer :service_id

      t.timestamps null: false
    end
  end
end
