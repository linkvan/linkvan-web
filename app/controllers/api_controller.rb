class ApiController < ApplicationController

	def getchanges
		localid = params[:localid]

		#Status needs at least 1 record - set manually
		if localid.to_i >= Status.last.id
			#uptodate success code = 42
			render :json => 42.to_json
		else
			allchanges = Hash.new

			#returned example: statusgrouped[0] returns last record (created most recent) of first grouping
			statusgrouped = Status.where("id > ?", localid).group(:fid)

			#build allchanges to return
			statusgrouped.each do |s|
				if s.changetype == "D"
					allchanges.store(s.id, {s.fid => s.changetype})
				else
					allchanges.store(s.id, {s.fid => Facility.find(s.fid)})
				end
			end
			render :json => allchanges.to_json
		end
	end

	def all
		render :json => Facility.all.to_json
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

      @filteredfacs = {:nearyesdistances => @facilities_near_yes_distance, :nearyes => @facilities_near_yes,
      					:nearnodistances => @facilities_near_no_distance, :nearno => @facilities_near_no,
      					 :nameyesdistances => @facilities_name_yes_distance,:nameyes => @facilities_name_yes,
      					 :namenodistances => @facilities_name_no_distance,:nameno => @facilities_name_no}.to_json

      render :json => @filteredfacs
	end

	def filteredtest
      @fs = { :nearyes => Facility.where("id<=3"), :nearno => Facility.where("id>8")}.to_json

      render :json => @fs
	end

	def show
		@facility = Facility.find(params[:id])
		render :json => @facility.to_json
	end

	def search
		if params[:search]
		  @facilities = Facility.search(params[:search])
		else
		  @facilities = Facility.all
		end

		render :json => @facilities.to_json
  	end

end
