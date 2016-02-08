class ChangeDateFormatInMyTable < ActiveRecord::Migration
  def change
  	 def up
    	change_column :accounts, :start_date, :string
  		end
  		def down
    	change_column :accounts, :end_date, :string
  		end
  end
end
