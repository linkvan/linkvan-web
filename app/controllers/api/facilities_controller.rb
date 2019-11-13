class Api::FacilitiesController < Api::ApplicationController

	# GET api/facilities
	def index
		@facilities = Facility.managed_by current_user

		@response = { facilities: FacilitiesSerializer.new(@facilities) }
		render json: @response, status: :ok
	end #/index

	# POST api/facilities
	def create
		@facility = current_user.facilities.create(facility_params)
		if @facility.errors.empty?
			FacilityStaticGenerator.new.perform
			render json: FacilitySerializer.new(@facility), status: :created
		else
			error_json = { errors: @facility.errors }
			render json: error_json, status: :unprocessable_entity
		end
	end #/create
	
	# PUT api/facilities/:id
	def update
		if current_user.manages.exists?(params[:id])
			@facility = Facility.find(params[:id])
			if @facility.update(facility_params)
				FacilityStaticGenerator.new.perform
				render json: FacilitySerializer.new(@facility), status: :ok
			else
				error_json = { errors: @facility.errors }
				render json: error_json, status: :unprocessable_entity
			end
		else
			head :not_found
		end
	end #/update

	# def filteredtest
  #     @fs = { :nearyes => Facility.where("id<=3"), :nearno => Facility.where("id>8")}.to_json

  #     render :json => @fs
	# end

	# def show
	# 	@facility = Facility.find(params[:id])
	# 	render :json => @facility.to_json
	# end

	# GET /run
	def generate_facilities
		FacilitiesStaticGeneratorJob.new.perform
		head :ok
	end #/generate_faciltiies
	
	private

	def facility_params
		params.permit(
			:name, :welcomes, :services,
			:address, :phone,
			:lat, :long, :verified,
			:website, :description, :notes,
			:r_pets, :r_id, :r_cart,
			:r_phone, :r_wifi,
			:shelter_note, :food_note, :medical_note,
			:hygiene_note, :technology_note, :legal_note,
			:learning_note, :zone_id,
			:startsmon_at, :endsmon_at,
			:startstues_at, :endstues_at,
			:startswed_at, :endswed_at,
			:startsthurs_at, :endsthurs_at,
			:startsfri_at, :endsfri_at,
			:startssat_at, :endssat_at,
			:startssun_at, :endssun_at,
			:startsmon_at2, :endsmon_at2,
			:startstues_at2, :endstues_at2,
			:startswed_at2, :endswed_at2,
			:startsthurs_at2, :endsthurs_at2,
			:startsfri_at2, :endsfri_at2,
			:startssat_at2, :endssat_at2,
			:startssun_at2, :endssun_at2,
			:open_all_day_mon, :open_all_day_tues,
			:open_all_day_wed, :open_all_day_thurs,
			:open_all_day_fri, :open_all_day_sat,
			:open_all_day_sun,
			:closed_all_day_mon, :closed_all_day_tues,
			:closed_all_day_wed, :closed_all_day_thurs,
			:closed_all_day_fri, :closed_all_day_sat,
			:closed_all_day_sun,
			:second_time_mon, :second_time_tues,
			:second_time_wed, :second_time_thurs,
			:second_time_fri, :second_time_sat,
			:second_time_sun
		)
	end #/facility_params

end #/FacilitiesController
