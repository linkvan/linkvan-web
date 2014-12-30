class FacilitiesController < ApplicationController
	def index
    end

    def filtered
      case params[:scope]
    	when 'Shelter'
      	@facilities = Facility.contains_service?("Shelter")
      	@facilities_name = @facilities.sort_by do |f|
      		f[:name]
      	end
    	when 'Food'
      	@facilities = Facility.contains_service?("Food")
    	when 'Medical'
      	@facilities = Facility.contains_service?("Medical")
    	when 'Hygiene'
      	@facilities = Facility.contains_service?("Hygiene")
        when 'Technology'
      	@facilities = Facility.contains_service?("Technology")
      	when 'Name'
      	@facilities = Facility.contains_service?("Medical")
    	else
      	@facilities = Facility.all
      end
	end


	def show
		@facility = Facility.find(params[:id])
	end

	def edit
		@facility = Facility.find(params[:id])
	end

	def update
		@facility = Facility.find(params[:id])
		@facility.update(facility_params)
		redirect_to @facility
	end

	def new
		@facility = Facility.new
	end

	def create
		@facility = Facility.new(facility_params)
		@facility.save
		redirect_to @facility
	end

	def destroy
		@facility = Facility.find(params[:id])
		@facility.destroy
		redirect_to facilities_url
	end


private

	def facility_params
		params.require(:facility).
							permit(:name, :welcomes, :services, :address, :phone, 
								:website, :description, :hours, :notes)
	end


end
