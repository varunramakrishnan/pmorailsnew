class Project < ActiveRecord::Base
	validates :project_code, :presence => true, :uniqueness => true
	belongs_to :account
	belongs_to :service
	before_save :upcase_fields

   def upcase_fields
      self.project_code.upcase!
   end
end
