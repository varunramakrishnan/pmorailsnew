class AddDetailsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :request_type, :string
    add_column :accounts, :date_of_request, :string
    add_column :accounts, :region, :string
    add_column :accounts, :contract_type, :string
    add_column :accounts, :location, :string
    add_column :accounts, :customer_contact, :string
    add_column :accounts, :other_persons, :text
    add_column :accounts, :other_sales_email, :string
    add_column :accounts, :sow_status, :string
    # add_column :accounts, :account_status, :string
    add_column :accounts, :comments, :string
    #add_column :accounts, :delivery_manager, :string
    add_column :accounts, :anticipated_value, :string
    add_column :accounts, :actual_value, :string
    add_column :accounts, :anticipated_start_date, :string
  end
end
