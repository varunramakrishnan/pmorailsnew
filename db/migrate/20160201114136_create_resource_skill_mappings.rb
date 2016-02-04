class CreateResourceSkillMappings < ActiveRecord::Migration
  def change
    create_table :resource_skill_mappings do |t|
      t.integer :resource_id
      t.integer :skill_id

      t.timestamps null: false
    end
  end
end
