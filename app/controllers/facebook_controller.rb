class FacebookController < ApplicationController
  layout "facebook"

  after_filter :allow_iframe


    def index
    @params = params
    @profiles = Profile.all
    @facebook_pages = FacebookPage.all

     def base64_url_decode str
     encoded_str = str.gsub('-','+').gsub('_','/')
     encoded_str += '=' while !(encoded_str.size % 4).zero?
     Base64.decode64(encoded_str)
    end

    def decode_data str
       encoded_sig, payload = str.split('.')
       data = ActiveSupport::JSON.decode base64_url_decode(payload)
    end

    if params.has_key? "signed_request"

    # require 'rest-graph'
    # rg = RestGraph.new( :app_id => "1440239169528450", :secret => "884240b8d9bf9d868a1bd0f0465c90bf")
    # @parsed_request = rg.parse_signed_request!(params["signed_request"])

      signed_request = params[:signed_request]
      @signed_request = decode_data(signed_request)
      
      if @signed_request != []
        
        @page_id = @signed_request["page"]["id"]
        @page_id = @page_id.to_s
        @page = FacebookPage.where(:fb_page_id => @page_id)
        @user_id = @page[0].user_id

        @user = User.find(@user_id)

        redirect_to facebook_url_path(@user)
      end

    else

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @profiles }
      end

    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
     @params = params
    #  signed_request = params[:signed_request] 
    #  @signed_request = decode_data(signed_request)
    
    # if params[:id] != "tagged" #weak
    #   @profile = Profile.find(params[:id])
    #   @posts = @profile.user.posts.order("created_at DESC").page(params[:page]).per(6)
    # end
    
    # respond_to do |format|
    #   if @profile
    #       format.html # show.html.erb
    #       format.json { render json: vanity_url_path(@profile) }
    #   else
    #       format.html { redirect_to root_url }
    #       format.json { render json: vanity_url_path(@profile).errors, status: :unprocessable_entity }
    #   end
    # end
  end


  private

  def allow_iframe
    response.headers["X-Frame-Options"] = "GOFORIT"
  end
end