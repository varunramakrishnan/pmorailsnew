class Role < ActiveRecord::Base
	validates :heirarchy_id, :presence => true, :uniqueness => true
end
