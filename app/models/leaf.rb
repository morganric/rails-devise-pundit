class Leaf < ActiveRecord::Base
	require 'acts-as-taggable-on'
	acts_as_taggable

	paginates_per 5

	extend FriendlyId
    friendly_id :title, use: [:slugged, :finders]

    validates_uniqueness_of [:slug, :title]
    validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,  :multiline => true 

	validates_exclusion_of :title, :in => %w( video audio text photo users feeds photos videos items admin oembed api facebook new popular featured favicon superuser 
    pages partners categories category creators platforms media posts authors types providers tagged ), :message => "You don't belong here"
	
	mount_uploader :image, ImageUploader
	mount_uploader :audio, AudioUploader
	mount_uploader :video, VideoUploader

	self.inheritance_column = nil

	belongs_to :user

	has_many :user_favs
    has_many :favourited_by, :through => :user_favs, :source => :user

    has_many :clicks

    def self.policy_class
	    LeafPolicy
	 end

    searchable do
    	text :title, :copy
	    # text :comments do
	    #   comments.map { |comment| comment.body }
	    # end

	    boolean :featured
	    integer :user_id

	    string  :sort_title do
	      title.downcase.gsub(/^(an?|the)/, '')
	    end
	end
end
