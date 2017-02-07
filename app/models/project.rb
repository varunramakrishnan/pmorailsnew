class Project < ActiveRecord::Base
	acts_as_paranoid
	validates :project_code, :presence => true, :uniqueness => true
	belongs_to :account
	belongs_to :service
	before_save :upcase_fields

reflections = Project.reflections.select do |association_name, reflection| 
  reflection.macro == :belongs_to
end

   def upcase_fields
      self.project_code.upcase!
   end

end
