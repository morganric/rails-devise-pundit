class Photo < ActiveRecord::Base
	extend FriendlyId
    friendly_id :title, use: [:slugged, :finders]

	mount_uploader :image, ImageUploader

	validates_uniqueness_of [:slug, :title]

	belongs_to :user

end
