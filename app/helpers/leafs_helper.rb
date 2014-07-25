module LeafsHelper

	include ActionView::Helpers::TextHelper
	include ActsAsTaggableOn::TagsHelper

	require 'embedly'
	require 'json'
	require 'open-uri'

	def url_handler

		embedly_api = Embedly::API.new :key => '8d4c76144f8711e1b4764040d3dc5c07'
		obj = embedly_api.oembed :url => @leaf.url

		@leaf.views = 1
		@leaf.type = obj[0].type
		@leaf.title = obj[0].title
		@leaf.copy =  obj[0].description
		@leaf.embed_code = obj[0].html
		@leaf.thumbnail_url = obj[0].thumbnail_url
		@leaf.remote_image_url = @leaf.thumbnail_url
		@leaf.provider = obj[0].provider_name

		if obj[0].type === nil || obj[0].type === "link" || obj[0].type === "rich"
			@leaf.type = "link"
		end

		if obj[0].provider_name === "Soundcloud" || obj[0].provider_name === "Spotify" || obj[0].provider_name === "Mixcloud"
			@leaf.type = "audio"
		end

		if obj[0].title === nil
			@leaf.title = @leaf.url
		end


		@leaf.tag_list.add(obj[0].type, obj[0].provider_name)

		# uploader = ImageUploader.new
		# uploader.download! @leaf.thumbnail_url
		# uploader.store!

	end


	def upload_tweet

		@user = @leaf.user
		@profile = @user.profile

		if @user.twitter_token != nil
			@client = Twitter::REST::Client.new do |config|
		      config.consumer_key        = "sUedRjJ0a8oHJJfHcnO1x5xBV"
		      config.consumer_secret     = "HikKRSrM2gNNDLRakwCGW1tYj3RkGrErISgE0HT8JqRr3pHVmR"
		      config.access_token        = @profile.user.twitter_token
		      config.access_token_secret = @profile.user.twitter_secret
		    end

		    @title = truncate(@leaf.title, lenght: 80)
			@client.update("Just embeded #{@title} on @embedtree - www.embedtree.com#{leaf_path(@leaf.id)}")
		end
	
	end


	def comment_tweet

	@leaf = Leaf.find(params[:leaf_id])
	@user = current_user
	@profile = @user.profile

	if @user.provider = "twitter"
		@client = Twitter::REST::Client.new do |config|
	      config.consumer_key        = "sUedRjJ0a8oHJJfHcnO1x5xBV"
	      config.consumer_secret     = "HikKRSrM2gNNDLRakwCGW1tYj3RkGrErISgE0HT8JqRr3pHVmR"
	      config.access_token        = @profile.user.twitter_token
	      config.access_token_secret = @profile.user.twitter_secret
	    end
	end

		@title = truncate(@leaf.title, lenght: 70)

		if @leaf.user.profile.twitter_handle != ""

			@client.update("Just commented on #{@title} on @embedtree >> www.embedtree.com#{leaf_path(@leaf.id)} via @#{@leaf.user.profile.twitter_handle}")
		
		else

			@client.update("Just commented on #{@title} on @embedtree >> www.embedtree.com#{leaf_path(@leaf.id)}")

		end

	end


	def upload_fb

		@user = @leaf.user
		@profile = @user.profile

		if @user.fb_token != nil
			@graph = Koala::Facebook::API.new(@profile.user.fb_token)
			@title = truncate(@leaf.title, lenght: 80)
			@graph.put_connections("me", "feed", :message => "Just embedded #{@title} on @embedtree - www.embedtree.com#{leaf_path(@leaf.id)}")
		end

	end


	def fav_tweet
		@leaf = Leaf.find(params[:user_fav][:leaf_id])
		@user = current_user
		@profile = @user.profile

		if @user.provider = "twitter"
			@client = Twitter::REST::Client.new do |config|
		      config.consumer_key        = "sUedRjJ0a8oHJJfHcnO1x5xBV"
		      config.consumer_secret     = "HikKRSrM2gNNDLRakwCGW1tYj3RkGrErISgE0HT8JqRr3pHVmR"
		      config.access_token        = @profile.user.twitter_token
		      config.access_token_secret = @profile.user.twitter_secret
		    end
		end

		@title = truncate(@leaf.title, lenght: 60)

		if @leaf.user.profile.twitter_handle != "" || @leaf.user.profile.twitter_handle != nil

		@client.update("Just favourited #{@title} on @embedtree >> www.embedtree.com#{leaf_path(@leaf.id)} via @#{@leaf.user.profile.twitter_handle}")
		else

		@client.update("Just favourited #{@title} on @embedtree >> www.embedtree.com#{leaf_path(@leaf.id)}")

		end
	end
end
