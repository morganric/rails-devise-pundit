class Category < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: [:slugged, :finders]

	validates_uniqueness_of [:slug, :name]
	has_many :user_categories
	has_many :users, :through => :user_categories
	
end
