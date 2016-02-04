class CreateHeirarchies < ActiveRecord::Migration
  def change
    create_table :heirarchies do |t|
      t.string :heirarchy_name

      t.timestamps null: false
    end
  end
end
