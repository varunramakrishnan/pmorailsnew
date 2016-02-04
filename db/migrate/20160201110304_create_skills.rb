class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :skill_type
      t.string :skill_name
      t.string :skill_code

      t.timestamps null: false
    end
  end
end
