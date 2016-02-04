class CreateOrganisationalUnitServiceMappings < ActiveRecord::Migration
  def change
    create_table :organisational_unit_service_mappings do |t|
      t.integer :organisational_unit_id
      t.integer :service_id

      t.timestamps null: false
    end
  end
end
