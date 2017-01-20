class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :attribute_type
      t.string :attribute_key
      t.string :attribute_value
      t.string :active_status

      t.timestamps null: false
    end
  end
end
