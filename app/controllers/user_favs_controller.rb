class UserFavsController < ApplicationController

	after_action :fav_email, only: :create
	after_action :fav_action, only: :create

	def create
		@user_fav = UserFav.create(user_fav_params)

		respond_to do |format|
	      if @user_fav.save
	        format.js { redirect_to :back, notice: 'Fav was successfully created.' }
	      else
	        format.js { redirect_to :back, notice: 'Fav was not successfully created.' }
	      end
	    end
	end

	def destroy

		@user_fav = UserFav.where(user_fav_params)
		respond_to do |format|
	      if @user_fav.first.destroy
	        format.js { redirect_to :back, notice: 'Fav was successfully created.' }
	      else
	        format.js { redirect_to :back, notice: 'Fav was not successfully created.' }
	      end
	    end
	end

	def fav_email
		@profile = current_user.profile
		@leaf = Leaf.find(params[:user_fav][:leaf_id])
		UserMailer.favourite_email(@profile.user, @leaf).deliver
	end

	def fav_action
		Activity.create!(:user_id => current_user.id, 
			:other_id => user_fav_params[:user_id], :leaf_id => user_fav_params[:leaf_id], :action => "Favourited")
	end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_fav_params
      params.require(:user_fav).permit(:leaf_id, :user_id)
    end



end
