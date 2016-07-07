class Service < ActiveRecord::Base
	validates :service_code, :presence => true, :uniqueness => true
	has_many :account_service_mappings,dependent: :destroy
	has_many :accounts, :through => :account_service_mappings
	has_many :organisational_unit_service_mappings,dependent: :destroy
  	has_many :organisational_units, :through => :organisational_unit_service_mappings
  	has_many :projects
end
