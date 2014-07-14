class ProfilesController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index, :facebook, :following, :followers]
  before_action :set_profile, only: [:show, :edit, :update, :destroy, :following, :followers]

  does_facebook

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @user = @profile.user
    @leafs = @profile.user.leafs.page(params[:all])
    # @public_photos = Photo.where(:user_id => @user.id, :public => true)
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  def apps
  end

  def dashboard
    @followed_users = current_user.followed_users
    @activities =  []
    @followed_users.each do |user|
      @activities << Activity.where(:user_id => user.id)
    end
    @activities = @activities[0].order(created_at: :desc)


  end

   def following
    @title = "Following"
    @user = @profile.user
    @users = @user.followed_users
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = @profile.user
    @users = @user.followers
    render 'show_follow'
  end

  def facebook
    @fb_app = fb_app
    @fb_params = fb_params
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to vanity_url_path(@profile.slug), notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: vanity_url_path(@profile.slug) }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:display_name, :bio, :image, :website, :date_of_birth, :location, :user_id, :latitude, :longitude)
    end
end
