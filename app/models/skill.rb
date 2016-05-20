class Skill < ActiveRecord::Base
	validates :skill_code, :presence => true, :uniqueness => true
	has_many :resource_skill_mappings,dependent: :destroy
	has_many :resources, :through => :resource_skill_mappings
end
