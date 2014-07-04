class FacebookPageController < ApplicationController
  def new
  	@facebook_page = FacebookPage.new
    respond_to do |format|
      format.html #new.html.erb
      format.js
      # format.json { render json: @facebook_page}
    end
  end

  def create
  	@facebook_page = FacebookPage.new(:fb_page_id => params[:fb_page_id], :user_id => current_user.id)

    respond_to do |format|
      if @facebook_page.save
      	format.js
        format.html { redirect_to @facebook_page, notice: "Save process completed!" }
        # format.json { render json: @facebook_page, status: :created, location: @facebook_page }
      else
        format.html { 
          flash.now[:notice]="Save proccess coudn't be completed!" 
          render :new 
        }
        format.js
        # format.json { render json: @facebook_page.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
  end
end