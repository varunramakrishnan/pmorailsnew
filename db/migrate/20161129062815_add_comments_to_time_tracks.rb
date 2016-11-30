class AddCommentsToTimeTracks < ActiveRecord::Migration
  def change
    add_column :time_tracks, :comments, :text
  end
end
