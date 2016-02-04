class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :service_name
      t.string :service_code

      t.timestamps null: false
    end
  end
end
