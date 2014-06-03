module LeafsHelper

	require 'embedly'
	require 'json'
	require 'open-uri'

	def url_handler

		embedly_api = Embedly::API.new :key => 'd30e91b2207a40469be014c739c2ddb3'
		obj = embedly_api.oembed :url => @leaf.url

		@leaf.views = 1
		@leaf.type = obj[0].type
		@leaf.title = obj[0].title
		@leaf.copy =  obj[0].description
		@leaf.embed_code = obj[0].html
		@leaf.thumbnail_url = obj[0].thumbnail_url
		@leaf.remote_image_url = @leaf.thumbnail_url

		# uploader = ImageUploader.new
		# uploader.download! @leaf.thumbnail_url
		# uploader.store!

	end

end
