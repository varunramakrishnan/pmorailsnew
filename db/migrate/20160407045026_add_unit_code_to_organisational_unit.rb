class AddUnitCodeToOrganisationalUnit < ActiveRecord::Migration
  def change
    add_column :organisational_units, :unit_code, :string
  end
end
