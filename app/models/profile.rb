class Profile < ActiveRecord::Base

	extend FriendlyId
  	friendly_id :user_name, use: [:slugged, :finders]

	mount_uploader :image, ImageUploader

	belongs_to :user

	protected

	  def user_name
	    user.name
	  end
end
