class OrganisationalUnit < ActiveRecord::Base
	acts_as_paranoid
	validates :unit_code, :presence => true, :uniqueness => true
	validates :unit_name, :presence => true
	has_many :accounts, dependent: :destroy
	has_many :organisational_unit_service_mappings, dependent: :destroy
	has_many :services, dependent: :destroy
  	has_many :services, :through => :organisational_unit_service_mappings, dependent: :destroy

  	before_save :upcase_fields

   def upcase_fields
      self.unit_code.upcase!
   end
end
