class AccountServiceMapping < ActiveRecord::Base
	belongs_to :account
    belongs_to :service
end
