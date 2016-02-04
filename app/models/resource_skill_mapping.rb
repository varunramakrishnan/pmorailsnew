class ResourceSkillMapping < ActiveRecord::Base
	belongs_to :skill
	belongs_to :resource
end
