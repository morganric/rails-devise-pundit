class ClicksController < ApplicationController

	def create
		@click = Click.create(click_params)

		respond_to do |format|
	      if @click.save
	        format.js# { redirect_to :back, notice: 'Fav was successfully created.' }
	      else
	        format.js# { redirect_to :back, notice: 'Fav was not successfully created.' }
	      end
	    end
	end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def click_params
      params.require(:click).permit(:leaf_id, :user_id)
    end



end
