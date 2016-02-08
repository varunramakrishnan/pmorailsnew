class Service < ActiveRecord::Base
	has_many :account_service_mappings
	has_many :accounts, :through => :account_service_mappings
	has_many :organisational_unit_service_mappings
  	has_many :organisational_units, :through => :organisational_unit_service_mappings
end
