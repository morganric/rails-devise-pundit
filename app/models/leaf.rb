class Leaf < ActiveRecord::Base
	 require 'acts-as-taggable-on'
	acts_as_taggable

	extend FriendlyId
    friendly_id :title, use: [:slugged, :finders]

    validates_uniqueness_of [:slug, :title]

	validates_exclusion_of :title, :in => %w( video audio text photo users feeds photos videos items admin oembed api facebook new popular featured favicon superuser 
    pages partners categories category creators platforms media posts authors types providers tagged ), :message => "You don't belong here"
	
	mount_uploader :image, ImageUploader
	mount_uploader :audio, AudioUploader
	mount_uploader :video, VideoUploader

	self.inheritance_column = nil

	belongs_to :user

end
