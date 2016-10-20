class AddColumnsToTimetrack < ActiveRecord::Migration
  def change
  	add_column :time_tracks, :account_id, :integer
  	add_column :time_tracks, :service_id, :integer
  end
end
