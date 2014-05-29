class LeafsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  before_action :set_leaf, only: [:show, :edit, :update, :destroy]

  # GET /leafs
  # GET /leafs.json
  def index
    @ago =  Time.now-7.days
    @leafs = Leaf.where('created_at > ?', @ago ).order("views DESC")
    @photos = Leaf.where(:type => "photo").order("views DESC")
    @texts = Leaf.where(:type => "text" ).order("views DESC")
    @videos = Leaf.where(:type => "video").order("views DESC")
    @audios = Leaf.where(:type => "audio").order("views DESC")
  end

  # GET /leafs/1
  # GET /leafs/1.json
  def show
    @leaf.views += 1
    @leaf.save
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

  # POST /leafs
  # POST /leafs.json
  def create
    @leaf = Leaf.new(leaf_params)
    @leaf.user = current_user.id

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
      params.require(:leaf).permit(:title, :copy, :image, :video, :audio, :url, :via_url, :live, :plays, :views, :user_id, :type)
    end
end
