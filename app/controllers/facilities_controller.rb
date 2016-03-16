class FacilitiesController < ApplicationController
  before_action :require_signin, only: [:edit, :update, :new, :create, :destroy]
  #use impressionist to log views to display on user show page

  def index
    @facilities = Facility.all
  end

    def filtered
      @latitude = params[:latitude]
      @longitude = params[:longitude]

      #use to catch undefined latlongs
      #if !(@latitude.nil?) || !(@longitude.nil?)
        #redirect_to facilities_url
      #end

      @scope = params[:scope]

      @facilities_near_yes_distance = Array.new
      @facilities_near_no_distance = Array.new
      @facilities_name_yes_distance = Array.new
      @facilities_name_no_distance = Array.new



      case params[:scope]
      when 'Shelter'
        @facilities_near_yes = Facility.contains_service("Shelter", "Near", "Yes", @latitude, @longitude)
        @facilities_near_no = Facility.contains_service("Shelter", "Near", "No", @latitude, @longitude)
        @facilities_name_yes = Facility.contains_service("Shelter", "Name", "Yes", @latitude, @longitude)
        @facilities_name_no = Facility.contains_service("Shelter", "Name", "No", @latitude, @longitude)
      when 'Food'
        @facilities_near_yes = Facility.contains_service("Food", "Near", "Yes", @latitude, @longitude)
        @facilities_near_no = Facility.contains_service("Food", "Near", "No", @latitude, @longitude)
        @facilities_name_yes = Facility.contains_service("Food", "Name", "Yes", @latitude, @longitude)
        @facilities_name_no = Facility.contains_service("Food", "Name", "No", @latitude, @longitude)
      when 'Medical'
        @facilities_near_yes = Facility.contains_service("Medical", "Near", "Yes", @latitude, @longitude)
        @facilities_near_no = Facility.contains_service("Medical", "Near", "No", @latitude, @longitude)
        @facilities_name_yes = Facility.contains_service("Medical", "Name", "Yes", @latitude, @longitude)
        @facilities_name_no = Facility.contains_service("Medical", "Name", "No", @latitude, @longitude)
      when 'Hygiene'
        @facilities_near_yes = Facility.contains_service("Hygiene", "Near", "Yes", @latitude, @longitude)
        @facilities_near_no = Facility.contains_service("Hygiene", "Near", "No", @latitude, @longitude)
        @facilities_name_yes = Facility.contains_service("Hygiene", "Name", "Yes", @latitude, @longitude)
        @facilities_name_no = Facility.contains_service("Hygiene", "Name", "No", @latitude, @longitude)
      when 'Technology'
        @facilities_near_yes = Facility.contains_service("Technology", "Near", "Yes", @latitude, @longitude)
        @facilities_near_no = Facility.contains_service("Technology", "Near", "No", @latitude, @longitude)
        @facilities_name_yes = Facility.contains_service("Technology", "Name", "Yes", @latitude, @longitude)
        @facilities_name_no = Facility.contains_service("Technology", "Name", "No", @latitude, @longitude)
      when 'Legal'
        @facilities_near_yes = Facility.contains_service("Legal", "Near", "Yes", @latitude, @longitude)
        @facilities_near_no = Facility.contains_service("Legal", "Near", "No", @latitude, @longitude)
        @facilities_name_yes = Facility.contains_service("Legal", "Name", "Yes", @latitude, @longitude)
        @facilities_name_no = Facility.contains_service("Legal", "Name", "No", @latitude, @longitude)
      when 'Search'
        @sortby = params[:sortby]
        @hours = params[:hours]
        @services = params[:services]
        @suitable = params[:suitable]
        @welcome = params[:welcome]

        if !(@suitable.nil?)
          suitableset = @suitable.split(",").to_set
        else
          suitableset = ["Children", "Youth", "Adults", "Seniors"].to_set
        end


        if !(@services.nil?)
          servicesarr = @services.split(",")
        else
          servicesarr = ["Shelter", "Food", "Medical", "Hygiene", "Technology", "Legal"]
        end

        @facilities_near_yes = []
        @facilities_near_no = []
        @facilities_name_yes = []
        @facilities_name_no = []

        servicesarr.each do |s|
          @facilities_near_yes = @facilities_near_yes.concat Facility.contains_service(s, "Near", "Yes", @latitude, @longitude)
          @facilities_near_no = @facilities_near_no.concat Facility.contains_service(s, "Near", "No", @latitude, @longitude)
          @facilities_name_yes = @facilities_name_yes.concat Facility.contains_service(s, "Name", "Yes", @latitude, @longitude)
          @facilities_name_no = @facilities_name_no.concat Facility.contains_service(s, "Name", "No", @latitude, @longitude)
        end


        @facilities_near_yes = Facility.redist_sort(@facilities_near_yes.uniq, @latitude, @longitude)
        @facilities_near_no = Facility.redist_sort(@facilities_near_no.uniq, @latitude, @longitude)
        @facilities_name_yes = Facility.rename_sort(@facilities_name_yes.uniq)
        @facilities_name_no = Facility.rename_sort(@facilities_name_no.uniq)

        #remove from each of the @facilities any facilities which don't contain the appropriate @welcome and @suitable
        if @welcome != "All"
          @facilities_near_yes.keep_if {|f| f.welcomes == @welcome}
          @facilities_near_no.keep_if {|f| f.welcomes == @welcome}
          @facilities_name_yes.keep_if {|f| f.welcomes == @welcome}
          @facilities_name_no.keep_if {|f| f.welcomes == @welcome}
        end

        if @suitable != "All" #refactor to "Everyone"
          @facilities_near_yes.keep_if {|e| e.suitability.split(" ").to_set.subset?(suitableset) || suitableset.subset?(e.suitability.split(" ").to_set)}
          @facilities_near_no.keep_if {|e| e.suitability.split(" ").to_set.subset?(suitableset) || suitableset.subset?(e.suitability.split(" ").to_set)}
          @facilities_name_yes.keep_if {|e| e.suitability.split(" ").to_set.subset?(suitableset) || suitableset.subset?(e.suitability.split(" ").to_set)}
          @facilities_name_no.keep_if {|e| e.suitability.split(" ").to_set.subset?(suitableset) || suitableset.subset?(e.suitability.split(" ").to_set)}
        end

      else
        @facilities_near_yes = Facility.all
        @facilities_near_no = Facility.all
        @facilities_name_yes = Facility.all
        @facilities_name_no = Facility.all
      end

      @facilities = Facility.all

      @facilities_near_yes.each do |f|
         @facilities_near_yes_distance.push(Facility.haversine_km(@latitude.to_d, @longitude.to_d, f.lat, f.long))
      end

      @facilities_near_no.each do |f|
         @facilities_near_no_distance.push(Facility.haversine_km(@latitude.to_d, @longitude.to_d, f.lat, f.long))
      end

      @facilities_name_yes.each do |f|
         @facilities_name_yes_distance.push(Facility.haversine_km(@latitude.to_d, @longitude.to_d, f.lat, f.long))
      end

      @facilities_name_no.each do |f|
         @facilities_name_no_distance.push(Facility.haversine_km(@latitude.to_d, @longitude.to_d, f.lat, f.long))
      end

      cookies[:lat_lon] = JSON.generate([@latitude, @longitude])

	  end

  def directions
    @facility = Facility.find(params[:id])
  end

  def options
  end

  def search
    if params[:search]
      @facilities = Facility.search(params[:search])
    else
      @facilities = Facility.all
    end
  end


	def show
		@facility = Facility.find(params[:id])
    impressionist(@facility, @facility.name)
	end

	def edit
		@facility = Facility.find(params[:id])
	end

	def update
		@facility = Facility.find(params[:id])
		if @facility.update(facility_params)
      Status.create(fid: @facility.id, changetype: "U")
		  redirect_to @facility
    else
      render :edit
    end
	end

	def new
		@facility = Facility.new
	end

	def create
		@facility = Facility.new(facility_params)
		if @facility.save
      Status.create(fid: @facility.id, changetype: "C")
		  redirect_to @facility
    else
      render :new
    end
	end

	def destroy
		@facility = Facility.find(params[:id])
    Status.create(fid: @facility.id, changetype: "D")
		@facility.destroy
		redirect_to facilities_url
	end


private

	def facility_params
		params.require(:facility).
							permit(:name, :welcomes, :services, :address, :phone,
								:website, :description, :startsmon_at, :endsmon_at, :startstues_at, :endstues_at,
                  :startswed_at, :endswed_at, :startsthurs_at, :endsthurs_at, :startsfri_at, :endsfri_at,
                    :startssat_at, :endssat_at, :startssun_at, :endssun_at, :notes, :suitability, :lat, :long,
                       :startsmon_at2, :endsmon_at2, :startstues_at2, :endstues_at2, :startswed_at2, :endswed_at2,
                          :startsthurs_at2, :endsthurs_at2, :startsfri_at2, :endsfri_at2, :startssat_at2, :endssat_at2,
                             :startssun_at2, :endssun_at2, :open_all_day_mon, :open_all_day_tues, :open_all_day_wed, :open_all_day_thurs,
                                :open_all_day_fri, :open_all_day_sat, :open_all_day_sun, :closed_all_day_mon, :closed_all_day_tues, :closed_all_day_wed,
                                   :closed_all_day_thurs, :closed_all_day_fri, :closed_all_day_sat, :closed_all_day_sun, :r_pets, :r_id, :r_cart, :r_phone, :r_wifi,
                                      :second_time_mon, :second_time_tues, :second_time_wed, :second_time_thurs, :second_time_fri, :second_time_sat, :second_time_sun )
	end


end
