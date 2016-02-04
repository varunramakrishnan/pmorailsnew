class Account < ActiveRecord::Base
	belongs_to :organisational_unit
  belongs_to :resource
  has_one :service, :through => :account_service_mapping
  has_many :resources, :through => :account_resource_mapping

end
