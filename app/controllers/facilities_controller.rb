class FacilitiesController < ApplicationController
  before_action :require_signin, except: [:new, :create]
	def index
    end

    def filtered
      @latitude = params[:latitude]
      @longitude = params[:longitude]
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
          servicesarr = ["Shelter", "Food", "Medical", "Hygiene", "Technology"]
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
   
	  end

  def directions
    @facility = Facility.find(params[:id])
  end

  def options
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
								:website, :description, :startsmon_at, :endsmon_at, :startstues_at, :endstues_at,
                  :startswed_at, :endswed_at, :startsthurs_at, :endsthurs_at, :startsfri_at, :endsfri_at,
                    :startssat_at, :endssat_at, :startssun_at, :endssun_at, :notes, :suitability, :lat, :long)
	end


end
