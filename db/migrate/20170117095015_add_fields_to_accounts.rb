class AddFieldsToAccounts < ActiveRecord::Migration
  def change
  	add_column :accounts, :owner, :string
  	add_column :accounts, :sales_stage, :string
  	add_column :accounts, :time_zone, :string
  	add_column :accounts, :market_size, :string
  	add_column :accounts, :currency, :string
  	add_column :accounts, :annual_forecast, :string
  	add_column :accounts, :closure_probability, :string
  	add_column :accounts, :weighted_forecast, :string
  	add_column :accounts, :received_date, :string
  	add_column :accounts, :expected_close_date, :string
  	add_column :accounts, :expected_close_month, :string
  	add_column :accounts, :actual_close_date, :string
  	add_column :accounts, :actual_closed_month, :string
  end
end




