class RelationshipsController < ApplicationController
  # before_action :signed_in_user

  after_action :follow_email, only: :create

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

  def follow_email
    @follower = current_user
    @followed = User.find(params[:relationship][:followed_id])
    UserMailer.follower_email(@followed, @follower).deliver
  end
end