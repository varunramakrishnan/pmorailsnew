class AlterAccountAndServiceMappings < ActiveRecord::Migration
  def change
  	remove_column :accounts, :start_date
	remove_column :accounts, :end_date
	remove_column :accounts, :resource_needed
	remove_column :accounts, :resource_allocated
	remove_column :accounts, :request_type
	remove_column :accounts, :date_of_request
	remove_column :accounts, :contract_type
	remove_column :accounts, :customer_contact
	remove_column :accounts, :other_persons
	remove_column :accounts, :other_sales_email
	remove_column :accounts, :status
	remove_column :accounts, :sow_status
	remove_column :accounts, :anticipated_value
	remove_column :accounts, :actual_value
	remove_column :accounts, :anticipated_start_date
	add_column :accounts, :project_status, :string
	add_column :accounts, :account_lob, :string
	add_column :accounts, :account_contact, :string
	add_column :accounts, :csm_contact, :string
	add_column :accounts, :sales_contact, :string
	add_column :accounts, :pm_contact, :string
	add_column :accounts, :overall_health, :string
	add_column :account_service_mappings, :no_of_people_needed, :integer
	add_column :account_service_mappings, :no_of_people_allocated, :integer
	add_column :account_service_mappings, :request_date, :string
	add_column :account_service_mappings, :start_date, :string
	add_column :account_service_mappings, :end_date, :string
	add_column :account_service_mappings, :contract_type, :string
	add_column :account_service_mappings, :project_status, :string
	add_column :account_service_mappings, :sow_status, :string
	add_column :account_service_mappings, :sow_signed_date, :string
	add_column :account_service_mappings, :currency, :string
	add_column :account_service_mappings, :anticipated_value, :integer
	add_column :account_service_mappings, :actual_value, :integer
	add_column :account_service_mappings, :anticipated_usd_value, :integer
	add_column :account_service_mappings, :actual_usd_value, :integer
	add_column :account_service_mappings, :health, :string
  end
end
