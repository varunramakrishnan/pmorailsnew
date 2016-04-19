class OrganisationalUnit < ActiveRecord::Base
	validates :unit_code, :presence => true, :uniqueness => true
	validates :unit_name, :presence => true
	has_many :accounts, dependent: :destroy
	has_many :organisational_unit_service_mappings
  	has_many :services, :through => :organisational_unit_service_mappings
end
