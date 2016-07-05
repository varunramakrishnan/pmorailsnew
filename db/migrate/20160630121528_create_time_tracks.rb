class CreateTimeTracks < ActiveRecord::Migration
  def change
    create_table :time_tracks do |t|
      t.integer :resource_id
      t.integer :user_id
      t.string :project_id
      t.string :date
      t.string :status

      t.timestamps null: false
    end
  end
end
