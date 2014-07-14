class Activity < ActiveRecord::Base
	belongs_to :user
	belongs_to :leaf

	def other
		User.find(self.other_id)
	end
end
