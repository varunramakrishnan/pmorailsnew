class ChangehrsLoggedTypeInpmo < ActiveRecord::Migration
  def change
  change_column :time_tracks, :hrs_logged, :float
  end
end




