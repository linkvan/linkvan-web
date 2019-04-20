require 'bigdecimal'
require 'bigdecimal/util'

class Facility < ActiveRecord::Base
	belongs_to :user
	validates :name, :lat, :long, :services, presence: true

	# is_impressionable

	scope :is_verified, -> {
		# where("verified = 't'") if (Rails.env.development? or Rails.env.test?)
		# where(verified: true) if Rails.env.production?
		where(verified: true)
	}

	def self.search(search)
		# where("lower(name) LIKE lower(?)", "%#{search}%") if (Rails.env.development? or Rails.env.test?)
		# where("name ILIKE ?", "%#{search}%") if Rails.env.production?
  		where("name ILIKE ?", "%#{search}%")
	end #/search

	def self.search_by_services(search)
		# where("lower(services) LIKE lower(?)", "%#{search}%") if (Rails.env.development? or Rails.env.test?)
		# where("services ILIKE ?", "%#{search}%") if Rails.env.production?
		where("services ILIKE ?", "%#{search}%")
	end #/search_by_services

	def is_open?(ctime = Time.now)
		cday = ctime.wday
		weekdays = [ :sun, :mon, :tues, :wed, :thurs, :fri, :sat ]
		wday = weekdays[cday]
		ret = false
		if self["open_all_day_#{wday}"]
			ret = true
		elsif self["closed_all_day_#{wday}"]
			ret = false
		elsif self["second_time_#{wday}"]
			ret = true
		elsif time_in_range?(ctime, wday)
			ret = true
		end
		return ret
	end #/is_open?

	def is_closed?(ctime = Time.now)
		!self.is_open?(ctime)
	end #/is_closed?

	def time_in_range?(ctime, wday)
		open1  = translate_time(ctime, self["starts#{wday}_at"])
		open2  = translate_time(ctime, self["starts#{wday}_at2"])
		close1 = translate_time(ctime, self["ends#{wday}_at"])
		close2 = translate_time(ctime, self["ends#{wday}_at2"])

		 if ( ctime >= open1 && ctime < close1 ) || (ctime >= open2 && ctime < close2 )
			return true
		 else
			return false
		 end
	end #/time_in_range?

	def translate_time(cdate, ftime)
		newdate = cdate.strftime('%Y-%m-%d')
		newtime = ftime.to_s(:time)
		newzone = ftime.zone
		# cdate = ctime.strftime('%I:%M:%P')
		Time.parse("#{newdate} #{newtime} #{newzone}")
	end #/translate_time

	def distance(ulat, ulong)
		Facility.haversine(self[:lat], self[:long], ulat, ulong)
	end

	def self.contains_service(service_query, prox, open, ulat, ulong)
		# TODO: Currently this method (Needs fix to simplify):
		#   - Fields like 'endsun_at' is using full DateTime, which makes
		#         impossible reasonable checks of open/closed facilities.
		#	- This method also compares open and close times with 8.hours.ago.
		#         If this is related with timezone, we should probably change this.
		ulat = ulat.to_d
		ulong = ulong.to_d

		#first query db for any facility whose services contains the service_query
		#and store in array arr
		arr = Facility.search_by_services(service_query).is_verified

		temp_arr = Array.new
		dist_arr = Array.new
		arr.each do |facility|
			if (open=="Yes")
				if facility.is_open?(8.hours.ago)
					temp_arr.push facility
					dist_arr.push facility.distance(ulat, ulong)
				end
			elsif (open=="No")
				if facility.is_closed?(8.hours.ago)
					temp_arr.push facility
					dist_arr.push facility.distance(ulat, ulong)
				end
			# else
			#   # Only for Testing purposes (should delete these lines later)
			# 	raise 'Error! Should not go into this one'
			end
		end #/arr.each

		ret_arr = Array.new
		if (prox=="Near")
			ret_arr = temp_arr.sort{ |f| f.distance(ulat, ulong) }
		elsif (prox=="Name")
			ret_arr = temp_arr.sort_by(&:name)
		end #/prox == Near, Name

		return ret_arr
	end #ends self.contains_service?

	def self.redist_sort(inArray, ulat, ulong)
		ulat = ulat.to_d
		ulong = ulong.to_d
		arr = Array.new
		distarr = Array.new

		inArray.each do |a|
			distarr.push(Facility.haversine(a.lat, a.long, ulat, ulong))
		end

		arr = Facility.bubble_sort(distarr, inArray)

		return arr
	end

	#use haversine and power to calculate distance between user's latlongs and facilities'
	def self.haversine(lat1, long1, lat2, long2)
		dtor = Math::PI/180
		r = 6378.14*1000 #delete 1000 to get kms

		rlat1 = lat1 * dtor
		rlong1 = long1 * dtor
		rlat2 = lat2 * dtor
		rlong2 = long2 * dtor

		dlon = rlong1 - rlong2
		dlat = rlat1 - rlat2

		a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
		c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
		d = r * c

		return d
	end

	def self.haversine_km(lat1, long1, lat2, long2)
		dtor = Math::PI/180
		r = 6378.14

		rlat1 = lat1 * dtor
		rlong1 = long1 * dtor
		rlat2 = lat2 * dtor
		rlong2 = long2 * dtor

		dlon = rlong1 - rlong2
		dlat = rlat1 - rlat2

		a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
		c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
		d = r * c

		return d
	end

	def self.haversine_min(lat1, long1, lat2, long2)
		km = self.haversine_km(lat1, long1, lat2, long2)
		time = km * 12.2 * 60 # avegrage 12.2 min/km walking
		return time.round(0) # time in seconds
	end

	def self.power(num, pow)
		num ** pow
	end

	# Sorts alist using list values as parameters
	#   Used in #contains_service to sort facilities by distance
	def self.bubble_sort(list, alist )
		return alist if list.size <= 1 # already sorted
		swapped = true
		while swapped do
			swapped = false
			0.upto(list.size-2) do |i|
				if list[i] > list[i+1]
					list[i], list[i+1] = list[i+1], list[i] # swap values
					alist[i], alist[i+1] = alist[i+1], alist[i]
					swapped = true
				end
			end
		end

		alist
	end

	def self.rename_sort(inArray)
		arr = Array.new
		arr = inArray.sort_by {|f| f[:name]}
		return arr
	end

	def self.to_csv
		attributes = %w{id name welcomes services lat long address phone website description notes created_at updated_at startsmon_at endsmon_at startstues_at endstues_at startswed_at endswed_at startsthurs_at endsthurs_at startsfri_at endsfri_at startssat_at endssat_at startssun_at endssun_at r_pets r_id r_cart r_phone r_wifi startsmon_at2 endsmon_at2 startstues_at2 endstues_at2 startswed_at2 endswed_at2 startsthurs_at2 endsthurs_at2 startsfri_at2 endsfri_at2 startssat_at2 endssat_at2 startssun_at2 endssun_at2 open_all_day_mon open_all_day_tues open_all_day_wed open_all_day_thurs open_all_day_fri open_all_day_sat open_all_day_sun closed_all_day_mon closed_all_day_tues closed_all_day_wed closed_all_day_thurs closed_all_day_fri closed_all_day_sat closed_all_day_sun second_time_mon second_time_tues second_time_wed second_time_thurs second_time_fri second_time_sat second_time_sun user_id verified shelter_note food_note medical_note hygiene_note technology_note legal_note learning_note}

		CSV.generate(headers: true) do |csv|
			csv << attributes

			all.each do |facility|
				csv << attributes.map{ |attr| facility.send(attr) }
			end
		end
	end

end #ends class
