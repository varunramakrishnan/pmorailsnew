class Skill < ActiveRecord::Base
	has_many :resource_skill_mappings
	has_many :resources, :through => :resource_skill_mappings
end
