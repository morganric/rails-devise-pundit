class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    # @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

    if current_user
	    @user = current_user
	    @user.fb_token = request.env["omniauth.auth"].credentials.token
	    @user.save

	    if @user.persisted?
	      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
	      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
	    else
	      session["devise.facebook_data"] = request.env["omniauth.auth"]
	      redirect_to new_user_registration_url
	    end
	else
		auth = request.env["omniauth.auth"]
		@user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

		if @user.persisted?
		  sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
	      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
	    else
	      session["devise.facebook_data"] = request.env["omniauth.auth"]
	      redirect_to new_user_registration_url
	    end

	end
  end

	def twitter

		if params[:category]

			auth = request.env["omniauth.auth"]
			@cat = Category.find(params[:category])

			@cat.twitter_token = auth.credentials.token
		    @cat.twitter_secret = auth.credentials.secret
		    @cat.twitter_handle = auth.extra.access_token.params[:screen_name]

		    @cat.save

		    redirect_to category_path(@cat)

		else
			auth = request.env["omniauth.auth"]
		    current_user.provider = auth.provider
			current_user.uid = auth.uid
			current_user.twitter_token = auth.credentials.token
		    current_user.twitter_secret = auth.credentials.secret
		    current_user.profile.twitter_handle = auth.extra.access_token.params[:screen_name]
		    # You need to implement the method below in your model (e.g. app/models/user.rb)
		    # @user = User.find_for_twitter_oauth(request.env["omniauth.auth"])
		    @user = current_user
		    @user.save
		    
		    if @user.persisted?
		      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
		      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
		    else
		      session["devise.twitter_data"] = request.env["omniauth.auth"]
		      redirect_to new_user_registration_url
		    end
		end

	end

end