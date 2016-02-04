class CreateOrganisationalUnits < ActiveRecord::Migration
  def change
    create_table :organisational_units do |t|
      t.string :unit_name

      t.timestamps null: false
    end
  end
end
