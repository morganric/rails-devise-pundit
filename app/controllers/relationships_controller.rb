class RelationshipsController < ApplicationController
  # before_action :signed_in_user

  after_action :follow_email, only: :create
  after_action :follow_action, only: :create
  # after_action :follow_tweet, only: :create

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    redirect_to vanity_url_path(@user)
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    redirect_to vanity_url_path(@user)
  end

  def follow_tweet

    @follower = current_user
    @profile = @follower.profile
    @followed = User.find(params[:relationship][:followed_id])

  if @user.provider = "twitter"
    @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "sUedRjJ0a8oHJJfHcnO1x5xBV"
        config.consumer_secret     = "HikKRSrM2gNNDLRakwCGW1tYj3RkGrErISgE0HT8JqRr3pHVmR"
        config.access_token        = @profile.user.twitter_token
        config.access_token_secret = @profile.user.twitter_secret
      end
  end

  if @followed.profile.twitter_handle != "" && @follower.profile.twitter_handle 

    @client.update("Just followed #{@followed.profile.display_name} (@#{@followed.profile.twitter_handle}) on @embedtree - www.embedtree.com/#{@followed.name} ")
  
  else

    @client.update("Just followed #{@followed.profile.display_name} on @embedtree - www.embedtree.com/#{@followed.name}")

  end

  end

  def follow_email
    @follower = current_user
    @followed = User.find(params[:relationship][:followed_id])
    UserMailer.follower_email(@followed, @follower).deliver
  end


  def follow_action
    Activity.create!(:user_id => current_user.id, 
      :other_id => params[:relationship][:followed_id], :action => "Followed")
  end
end