class UserMailer < ActionMailer::Base
  default from: 'beta@embedtree.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://embedtree.com/login'
    mail(to: @user.email, subject: 'Welcome to EmbedTree')
  end

  def favourite_email(user, leaf)
    @user = user
    @leaf = leaf
    @owner = leaf.user
    @title = leaf.title
    @url  = vanity_leaf_url_path(:id => @leaf.slug, :user_id => leaf.user.profile.slug)
    mail(to: @owner.email, subject: 'EmbedTree Favourite')
  end

  def follower_email(followed, follower)
    @followed = followed
    @follower = follower
    @url  = vanity_url_path(@follower.profile.slug)
    mail(to: @followed.email, subject: 'New EmbedTree Follower')
  end

  def upload_email(uploader, follower, leaf)
    @uploader = uploader
    @leaf = leaf
    @follower = follower
    @title = leaf.title
    @url  = vanity_leaf_url_path(:id => @leaf.slug, :user_id => leaf.user.profile.slug)
    mail(to: @follower.email, subject: 'New EmbedTree Upload')
  end 

  def category_email(user, category)
    @user = user
    @category = category
    @url  = category_path(category)
    mail(to: @user.email, subject: 'EmbedTree Category Feature')
  end

  def comment_email(commenter, user, leaf)
    @commenter = commenter
    @leaf = leaf
    @user = user
    @title = leaf.title
    @url  = vanity_leaf_url_path(:id => @leaf.slug, :user_id => leaf.user.profile.slug)
    mail(to: @user.email, subject: 'New EmbedTree Comment')
  end 
end