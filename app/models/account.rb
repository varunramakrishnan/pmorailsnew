class Account < ActiveRecord::Base
  acts_as_paranoid
	validates :account_code, :presence => true, :uniqueness => true
  validates :organisational_unit_id, :presence => true
	belongs_to :organisational_unit
  has_many :account_service_mappings,dependent: :destroy
  has_many :account_resource_mappings,dependent: :destroy
  has_many :projects,dependent: :destroy
  has_many :services, :through => :account_service_mappings
  has_many :resources, :through => :account_resource_mappings
  # before_save :upcase_fields

   def upcase_fields
      self.account_code.upcase!
   end

end
