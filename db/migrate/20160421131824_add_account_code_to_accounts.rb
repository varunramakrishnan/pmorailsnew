class AddAccountCodeToAccounts < ActiveRecord::Migration
  def change
  	add_column :accounts, :account_code, :string
  end
end
