class Resource < ActiveRecord::Base
	validates :employee_id, :uniqueness => true
	validates :mail, :presence => true, :uniqueness => true
	# has_many :accounts, dependent: :destroy
	has_many :accounts
	has_many :resource_skill_mappings, dependent: :destroy
	has_many :account_resource_mappings, dependent: :destroy
  has_many :accounts, :through => :account_resource_mappings
  has_many :skills, through: :resource_skill_mappings
  
end
