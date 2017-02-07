class AccountResourceMapping < ActiveRecord::Base
	# acts_as_paranoid
	belongs_to :account
    belongs_to :resource
end
