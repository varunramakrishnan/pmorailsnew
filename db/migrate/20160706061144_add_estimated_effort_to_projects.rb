class AddEstimatedEffortToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :estimated_efforts, :integer
  	add_column :time_tracks, :hrs_logged, :integer
  end
end
