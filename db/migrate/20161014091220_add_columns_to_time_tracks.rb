class AddColumnsToTimeTracks < ActiveRecord::Migration
  def change
  	add_column :time_tracks, :week_id, :string
  	add_column :users, :employee_id, :string
  end
end
