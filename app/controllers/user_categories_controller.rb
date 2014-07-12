class UserCategoriesController < ApplicationController

	after_action :category_email, only: :create

	def create
		@user_category = UserCategory.create(user_category_params)

		respond_to do |format|
	      if @user_category.save
	        format.js# { redirect_to :back, notice: 'Fav was successfully created.' }
	      else
	        format.js# { redirect_to :back, notice: 'Fav was not successfully created.' }
	      end
	    end
	end

	def destroy
		@user_category = UserCategory.where(user_category_params)

		respond_to do |format|
	      if @user_category.first.destroy
	        format.js# { redirect_to :back, notice: 'Fav was successfully created.' }
	      else
	        format.js# { redirect_to :back, notice: 'Fav was not successfully created.' }
	      end
	    end
	end

 def category_email
    @user = User.find(user_category_params[:user_id])
    @category = Category.find(user_category_params[:category_id])
    UserMailer.category_email(@user, @category).deliver
    
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_category_params
      params.require(:user_category).permit(:category_id, :user_id)
    end



end
