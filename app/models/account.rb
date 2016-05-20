class Account < ActiveRecord::Base
	belongs_to :organisational_unit
  has_many :account_service_mappings,dependent: :destroy
  has_many :account_resource_mappings,dependent: :destroy
  has_many :services, :through => :account_service_mappings
  has_many :resources, :through => :account_resource_mappings

end
