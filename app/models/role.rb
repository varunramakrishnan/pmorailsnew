class Role < ActiveRecord::Base
	acts_as_paranoid
	# validates :heirarchy_id, :presence => true, :uniqueness => true
	validates :role_code, :presence => true, :uniqueness => true
	before_save :upcase_fields

   def upcase_fields
      self.role_code.upcase!
   end
end
