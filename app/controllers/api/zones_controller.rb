class Api::ZonesController < Api::ApplicationController

    # GET api/zones
    def index
      @response = { zones: [] }
      render json: @response, status: :ok
      end #/index

    # PUT api/zones/:id/user
    def assign_user
			error_json = { error: 'Functionality still in development' }
			render json: error_json, status: :unprocessable_entity
    end #/assign_user

    # DELETE api/zones/:id/user
    def unassign_user
			error_json = { error: 'Functionality still in development' }
			render json: error_json, status: :unprocessable_entity
    end #/unassign_user

	
	# def filteredtest
  #     @fs = { :nearyes => Facility.where("id<=3"), :nearno => Facility.where("id>8")}.to_json

  #     render :json => @fs
	# end

	# def show
	# 	@facility = Facility.find(params[:id])
	# 	render :json => @facility.to_json
	# end

end #/ZonesController
