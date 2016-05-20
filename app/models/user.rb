class User < ActiveRecord::Base
	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
	validates :password, :presence => true
		def self.authenticate(username, password)
	    user = User.find_by_username(username)
	    if user && user.password == password
	      user
	    else
	      nil
	    end
	  end
end
