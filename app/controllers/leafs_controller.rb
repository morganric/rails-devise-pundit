class LeafsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index, :tag, :featured, :media, :search]
  before_action :set_leaf, only: [:show, :edit, :update, :destroy]

  include LeafsHelper

  # GET /leafs
  # GET /leafs.json
  def index
    @ago =  Time.now-7.days 
    

    if current_user && current_user.admin?
      @leafs = Leaf.all.page
    else
      @leafs = Leaf.where(:live => true).page
    end

      @leafs = @leafs.where('created_at > ?', @ago ).order("views DESC").page(params[:all])
      @photos = @leafs.where(:type => "photo").page(params[:photos])
      @texts = @leafs.where(:type => "text" ).page(params[:texts])
      @videos = @leafs.where(:type => "video").page(params[:videos])
      @audios = @leafs.where(:type => "audio").page(params[:audios])
      @links = @leafs.where(:type => "link").page(params[:links])

    @featured = @leafs.where(:featured => true).limit(6)
      

  end

  # GET /leafs/1
  # GET /leafs/1.json
  def show

    unless current_user && current_user.admin?
      if @leaf.live == false
        redirect_to root_path, notice: 'Sorry, nohting here.'
      end
    end

    @leaf.views += 1
    @leaf.save
  end

  def admin

    @users = User.all
    @leafs = Leaf.all
    @views_total = 0
    @clicks_total = 0
    @favs_total = 0

    @leafs.each do |leaf|
      @views_total = @views_total + leaf.views
      @clicks_total = @clicks_total + leaf.clicks.count
      @favs_total = @favs_total + leaf.favourited_by.count
    end

  end

  def search

    search = Leaf.search do
      fulltext params[:q]
    end

    user_search = User.search do
      fulltext params[:q]
    end

    @users = user_search.results
    @leafs = search.results
    @featured = Leaf.where(:featured => true).limit(6)

  end

  # GET /leafs/new
  def new
    @leaf = Leaf.new
  end

  # GET /leafs/new/audio
  def audio
    @leaf = Leaf.new
  end

  # GET /leafs/new/video
  def video
    @leaf = Leaf.new
  end

  # GET /leafs/new/photo
  def photo
    @leaf = Leaf.new
  end

  # GET /leafs/new/text
  def text
    @leaf = Leaf.new
  end

  # GET /leafs/1/edit
  def edit
  end

  # acts_as_taggable
  def tag
    if current_user && current_user.admin?
      @leafs = Leaf.all
    else
      @leafs = Leaf.where(:live => true) 
    end
    @leafs = @leafs.tagged_with(params[:id]).page(params[:all])
    @photos = @leafs.where(:type => "photo")
    @texts = @leafs.where(:type => "text" )
    @videos = @leafs.where(:type => "video")
    @audios = @leafs.where(:type => "audio")
    @links = @leafs.where(:type => "link").page(params[:links])
    @featured = @leafs.where(:featured => true).limit(6)
    
    @tags = Leaf.tag_counts_on(:tags)
    render :action => 'index'
  end

  def media
    if current_user && current_user.admin?
      @leafs = Leaf.all
    else
      @leafs = Leaf.where(:live => true) 
    end
    @leafs = @leafs.where(:type => params[:type]).page(params[:all])
    @photos = @leafs.where(:type => "photo")
    @texts = @leafs.where(:type => "text" )
    @videos = @leafs.where(:type => "video")
    @audios = @leafs.where(:type => "audio")
    @links = @leafs.where(:type => "link").page(params[:links])
    @featured = @leafs.where(:featured => true).limit(6)
    
    @tags = Leaf.tag_counts_on(:tags)
    render :action => 'index'
  end

  def featured
    @leafs = Leaf.where(:featured =>  true).order('created_at DESC').limit(6)
    @featured = @leafs.where(:featured => true).limit(6)
    # render :action => 'index'

  end

  # POST /leafs
  # POST /leafs.json
  def create
    @leaf = Leaf.new(leaf_params)
    @leaf.user_id = current_user.id

    if @leaf.via_url
      url_handler
    end

    respond_to do |format|
      if @leaf.save
        format.html { redirect_to @leaf, notice: 'Leaf was successfully created.' }
        format.json { render :show, status: :created, location: @leaf }
      else
        format.html { render :new }
        format.json { render json: @leaf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leafs/1
  # PATCH/PUT /leafs/1.json
  def update
    respond_to do |format|
      if @leaf.update(leaf_params)
        format.html { redirect_to @leaf, notice: 'Leaf was successfully updated.' }
        format.json { render :show, status: :ok, location: @leaf }
      else
        format.html { render :edit }
        format.json { render json: @leaf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leafs/1
  # DELETE /leafs/1.json
  def destroy
    @leaf.destroy
    respond_to do |format|
      format.html { redirect_to leafs_url, notice: 'Leaf was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leaf
      @leaf = Leaf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leaf_params
      params.require(:leaf).permit(:title, :copy, :image, :video, :audio, :url, :via_url,
       :live, :plays, :views, :user_id, :type, :tag_list, :featured)
    end
end
