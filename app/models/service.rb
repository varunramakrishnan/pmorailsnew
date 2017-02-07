class Service < ActiveRecord::Base
  acts_as_paranoid
	validates :service_code, :presence => true, :uniqueness => true
	has_many :account_service_mappings,dependent: :destroy
	has_many :accounts, :through => :account_service_mappings
	has_many :organisational_unit_service_mappings,dependent: :destroy
  	has_many :organisational_units, :through => :organisational_unit_service_mappings
  	has_many :projects

  	before_save :upcase_fields

   def upcase_fields
      self.service_code.upcase!
   end
end
