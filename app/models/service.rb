class Service < ActiveRecord::Base
	has_one :account, :through => :account_service_mapping
  has_many :organisational_units, :through => :organisational_unit_service_mapping
end
