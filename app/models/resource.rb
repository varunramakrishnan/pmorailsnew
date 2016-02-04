class Resource < ActiveRecord::Base
	has_many :accounts, dependent: :destroy
	has_many :resource_skill_mappings
  has_many :accounts, :through => :account_resource_mappings
  has_many :skills, through: :resource_skill_mappings
end
