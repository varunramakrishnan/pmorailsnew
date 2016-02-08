class ChangeDateFormatInAccountsTable < ActiveRecord::Migration
  def change
    	change_column :accounts, :start_date, :string
    	change_column :accounts, :end_date, :string
  end
end
