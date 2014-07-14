class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_activity
  
  def create
  	@activity = Activity.create(activity_params)
  	@ctivity.save
  end

  private

  def set_activity
      @activity = Activity.find(params[:id])
    end

	# Never trust parameters from the scary internet, only allow the white list through.
	def activity_params
	  params.require(:activity).permit(:leaf_id, :user_id, :other_id, :action)
	end

end