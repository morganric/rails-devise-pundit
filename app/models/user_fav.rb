class UserFav < ActiveRecord::Base
	belongs_to :leaf
	belongs_to :user
end
