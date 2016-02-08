class OrganisationalUnitServiceMapping < ActiveRecord::Base
	belongs_to :organisational_unit
	belongs_to :service
end
