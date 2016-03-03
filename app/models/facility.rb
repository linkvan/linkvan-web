require 'bigdecimal'
require 'bigdecimal/util'

class Facility < ActiveRecord::Base
	belongs_to :user
	validates :name, :lat, :long, :services, presence: true

	is_impressionable
	
	def self.search(search)
		#where("name ILIKE ?", "%#{search}%") for production
		#where("name LIKE ?", "%#{search}%") for development
  		where("name ILIKE ?", "%#{search}%")
	end

	def self.contains_service(service_query, prox, open, ulat, ulong)
		arr = Array.new
		distarr = Array.new
		day = 8.hours.ago.wday

		ulat = ulat.to_d
		ulong = ulong.to_d

		#first query db for any facility whose services contains the service_query
		#and store in array arr
		facility = Facility.select("services", "id")

		facility.each do |f|
			if f.services.include?(service_query)
				arr.push(Facility.find(f.id))
			end
		end




		#second use prox and open to delete the appropriate elements from arr
		if ((prox=="Near") && (open=="Yes"))
			arr.each do |a|
				distarr.push(Facility.haversine(a.lat, a.long, ulat, ulong))
			end

			arr = Facility.bubble_sort(distarr, arr)

			temp_arr = Array.new
			temp_arr = arr

			$i = 0

			while $i < temp_arr.count  do

			case day
				when 0
					#in the end, temp_arr is assigned back to arr and then arr is returned
					#if the current time for a given day is less than the start time and greater than the finish time
					#that means the current facility is closed, so we delete it from temp_arr
					#!SUNDAY DONE... PICK UP AT "when 1" - test then replicate for other cases (when 1...etc)
					if arr[$i].closed_all_day_sun
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].open_all_day_sun
					elsif arr[$i].second_time_sun
						if (8.hours.ago.hour < arr[$i].startssun_at.hour.to_i) || (8.hours.ago.hour > arr[$i].endssun_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour > arr[$i].endssun_at.hour.to_i) && (8.hours.ago.hour < arr[$i].startssun_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startssun_at.hour.to_i && 8.hours.ago.min <= arr[$i].startssun_at.min.to_i) || (8.hours.ago.hour == arr[$i].endssun_at2.hour.to_i && 8.hours.ago.min >= arr[$i].endssun_at2.min.to_i) 
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endssun_at.hour.to_i && 8.hours.ago.hour == arr[$i].startssun_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endssun_at.min.to_i && 8.hours.ago.min < arr[$i].startssun_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endssun_at.hour.to_i && arr[$i].endssun_at.hour.to_i < arr[$i].startssun_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endssun_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startssun_at2.hour.to_i && arr[$i].endssun_at.hour.to_i < arr[$i].startssun_at2.hour.to_i) && (8.hours.ago.min <= arr[$i].startssun_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i < arr[$i].startssun_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].endssun_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].endssun_at.hour.to_i) && (8.hours.ago.min.to_i >= arr[$i].endssun_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].startssun_at.hour.to_i) && (8.hours.ago.min.to_i < arr[$i].endssun_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					end
				when 1
					if arr[$i].closed_all_day_mon
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].open_all_day_mon
					elsif arr[$i].second_time_mon
						if (8.hours.ago.hour < arr[$i].startsmon_at.hour.to_i) || (8.hours.ago.hour > arr[$i].endsmon_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour > arr[$i].endsmon_at.hour.to_i) && (8.hours.ago.hour < arr[$i].startsmon_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour == arr[$i].startsmon_at.hour.to_i && 8.hours.ago.min <= arr[$i].startsmon_at.min.to_i) || (8.hours.ago.hour == arr[$i].endsmon_at2.hour.to_i && 8.hours.ago.min >= arr[$i].endsmon_at2.min.to_i) 
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour == arr[$i].endsmon_at.hour.to_i && 8.hours.ago.hour == arr[$i].startsmon_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endsmon_at.min.to_i && 8.hours.ago.min < arr[$i].startsmon_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endsmon_at.hour.to_i && arr[$i].endsmon_at.hour.to_i < arr[$i].startsmon_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endsmon_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startsmon_at2.hour.to_i && arr[$i].endsmon_at.hour.to_i < arr[$i].startsmon_at2.hour.to_i) && (8.hours.ago.min <= arr[$i].startsmon_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else

						if (8.hours.ago.hour.to_i < arr[$i].startsmon_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].endsmon_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].endsmon_at.hour.to_i) && (8.hours.ago.min.to_i >= arr[$i].endsmon_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startsmon_at.hour.to_i) && (8.hours.ago.min.to_i < arr[$i].endsmon_at.min.to_i)

							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					end
				when 2
					if arr[$i].closed_all_day_tues
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].open_all_day_tues
					elsif arr[$i].second_time_tues
						if (8.hours.ago.hour < arr[$i].startstues_at.hour.to_i) || (8.hours.ago.hour > arr[$i].endstues_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour > arr[$i].endstues_at.hour.to_i) && (8.hours.ago.hour < arr[$i].startstues_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startstues_at.hour.to_i && 8.hours.ago.min <= arr[$i].startstues_at.min.to_i) || (8.hours.ago.hour == arr[$i].endstues_at2.hour.to_i && 8.hours.ago.min >= arr[$i].endstues_at2.min.to_i) 
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endstues_at.hour.to_i && 8.hours.ago.hour == arr[$i].startstues_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endstues_at.min.to_i && 8.hours.ago.min < arr[$i].startstues_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endstues_at.hour.to_i && arr[$i].endstues_at.hour.to_i < arr[$i].startstues_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endstues_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startstues_at2.hour.to_i && arr[$i].endstues_at.hour.to_i < arr[$i].startstues_at2.hour.to_i) && (8.hours.ago.min <= arr[$i].startstues_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i < arr[$i].startstues_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].endstues_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].endstues_at.hour.to_i) && (8.hours.ago.min.to_i >= arr[$i].endstues_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].startstues_at.hour.to_i) && (8.hours.ago.min.to_i < arr[$i].endstues_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					end
				when 3
					if arr[$i].closed_all_day_wed
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].open_all_day_wed
					elsif arr[$i].second_time_wed
						if (8.hours.ago.hour < arr[$i].startswed_at.hour.to_i) || (8.hours.ago.hour > arr[$i].endswed_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour > arr[$i].endswed_at.hour.to_i) && (8.hours.ago.hour < arr[$i].startswed_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startswed_at.hour.to_i && 8.hours.ago.min <= arr[$i].startswed_at.min.to_i) || (8.hours.ago.hour == arr[$i].endswed_at2.hour.to_i && 8.hours.ago.min >= arr[$i].endswed_at2.min.to_i) 
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endswed_at.hour.to_i && 8.hours.ago.hour == arr[$i].startswed_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endswed_at.min.to_i && 8.hours.ago.min < arr[$i].startswed_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endswed_at.hour.to_i && arr[$i].endswed_at.hour.to_i < arr[$i].startswed_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endswed_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startswed_at2.hour.to_i && arr[$i].endswed_at.hour.to_i < arr[$i].startswed_at2.hour.to_i) && (8.hours.ago.min <= arr[$i].startswed_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i < arr[$i].startswed_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].endswed_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].endswed_at.hour.to_i) && (8.hours.ago.min.to_i >= arr[$i].endswed_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].startswed_at.hour.to_i) && (8.hours.ago.min.to_i < arr[$i].endswed_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					end
				when 4
					if arr[$i].closed_all_day_thurs
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].open_all_day_thurs
					elsif arr[$i].second_time_thurs
						if (8.hours.ago.hour < arr[$i].startsthurs_at.hour.to_i) || (8.hours.ago.hour > arr[$i].endsthurs_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour > arr[$i].endsthurs_at.hour.to_i) && (8.hours.ago.hour < arr[$i].startsthurs_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startsthurs_at.hour.to_i && 8.hours.ago.min <= arr[$i].startsthurs_at.min.to_i) || (8.hours.ago.hour == arr[$i].endsthurs_at2.hour.to_i && 8.hours.ago.min >= arr[$i].endsthurs_at2.min.to_i) 
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endsthurs_at.hour.to_i && 8.hours.ago.hour == arr[$i].startsthurs_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endsthurs_at.min.to_i && 8.hours.ago.min < arr[$i].startsthurs_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endsthurs_at.hour.to_i && arr[$i].endsthurs_at.hour.to_i < arr[$i].startsthurs_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endsthurs_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startsthurs_at2.hour.to_i && arr[$i].endsthurs_at.hour.to_i < arr[$i].startsthurs_at2.hour.to_i) && (8.hours.ago.min <= arr[$i].startsthurs_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i < arr[$i].startsthurs_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].endsthurs_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].endsthurs_at.hour.to_i) && (8.hours.ago.min.to_i >= arr[$i].endsthurs_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].startsthurs_at.hour.to_i) && (8.hours.ago.min.to_i < arr[$i].endsthurs_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					end
				when 5
					if arr[$i].closed_all_day_fri
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].open_all_day_fri
					elsif arr[$i].second_time_fri
						if (8.hours.ago.hour < arr[$i].startsfri_at.hour.to_i) || (8.hours.ago.hour > arr[$i].endsfri_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour > arr[$i].endsfri_at.hour.to_i) && (8.hours.ago.hour < arr[$i].startsfri_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startsfri_at.hour.to_i && 8.hours.ago.min <= arr[$i].startsfri_at.min.to_i) || (8.hours.ago.hour == arr[$i].endsfri_at2.hour.to_i && 8.hours.ago.min >= arr[$i].endsfri_at2.min.to_i) 
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endsfri_at.hour.to_i && 8.hours.ago.hour == arr[$i].startsfri_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endsfri_at.min.to_i && 8.hours.ago.min < arr[$i].startsfri_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endsfri_at.hour.to_i && arr[$i].endsfri_at.hour.to_i < arr[$i].startsfri_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endsfri_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startsfri_at2.hour.to_i && arr[$i].endsfri_at.hour.to_i < arr[$i].startsfri_at2.hour.to_i) && (8.hours.ago.min <= arr[$i].startsfri_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i < arr[$i].startsfri_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].endsfri_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].endsfri_at.hour.to_i) && (8.hours.ago.min.to_i >= arr[$i].endsfri_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].startsfri_at.hour.to_i) && (8.hours.ago.min.to_i < arr[$i].endsfri_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					end
				else
					if arr[$i].closed_all_day_sat
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].open_all_day_sat
					elsif arr[$i].second_time_sat
						if (8.hours.ago.hour < arr[$i].startssat_at.hour.to_i) || (8.hours.ago.hour > arr[$i].endssat_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour > arr[$i].endssat_at.hour.to_i) && (8.hours.ago.hour < arr[$i].startssat_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startssat_at.hour.to_i && 8.hours.ago.min <= arr[$i].startssat_at.min.to_i) || (8.hours.ago.hour == arr[$i].endssat_at2.hour.to_i && 8.hours.ago.min >= arr[$i].endssat_at2.min.to_i) 
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endssat_at.hour.to_i && 8.hours.ago.hour == arr[$i].startssat_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endssat_at.min.to_i && 8.hours.ago.min < arr[$i].startssat_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endssat_at.hour.to_i && arr[$i].endssat_at.hour.to_i < arr[$i].startssat_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endssat_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startssat_at2.hour.to_i && arr[$i].endssat_at.hour.to_i < arr[$i].startssat_at2.hour.to_i) && (8.hours.ago.min <= arr[$i].startssat_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i < arr[$i].startssat_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].endssat_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].endssat_at.hour.to_i) && (8.hours.ago.min.to_i >= arr[$i].endssat_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].startssat_at.hour.to_i) && (8.hours.ago.min.to_i < arr[$i].endssat_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					end

			end #ends case day

			$i +=1

			end #ends while loop


		elsif ((prox=="Near") && (open=="No"))

			arr.each do |a|
				distarr.push(Facility.haversine(a.lat, a.long, ulat, ulong))
			end


			arr = Facility.bubble_sort(distarr, arr)
			temp_arr = Array.new
			temp_arr = arr

			$i = 0

			while $i < temp_arr.count  do

			case day
				when 0
					if arr[$i].open_all_day_sun
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].closed_all_day_sun
					elsif arr[$i].second_time_sun
						if (8.hours.ago.hour.to_i > arr[$i].startssun_at.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endssun_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].startssun_at2.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endssun_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startssun_at.hour.to_i && 8.hours.ago.min >= arr[$i].startssun_at.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssun_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endssun_at.hour.to_i && 8.hours.ago.min <= arr[$i].endssun_at.min.to_i) && (8.hours.ago.hour.to_i > arr[$i].startssun_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startssun_at2.hour.to_i && 8.hours.ago.min >= arr[$i].startssun_at2.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssun_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endssun_at2.hour.to_i && 8.hours.ago.min <= arr[$i].endssun_at2.min.to_i) && (8.hours.ago.hour.to_i >arr[$i].startssun_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else

						if (8.hours.ago.hour.to_i > arr[$i].startssun_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssun_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif ((8.hours.ago.hour.to_i == arr[$i].endssun_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endssun_at.min.to_i)) && (8.hours.ago.hour.to_i > arr[$i].startssun_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif ((8.hours.ago.hour.to_i == arr[$i].startssun_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endssun_at.min.to_i)) && (8.hours.ago.hour.to_i < arr[$i].endssun_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						
						end
					end
				when 1
					if arr[$i].open_all_day_mon
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].closed_all_day_mon
					elsif arr[$i].second_time_mon
						if (8.hours.ago.hour.to_i > arr[$i].startsmon_at.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endsmon_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].startsmon_at2.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endsmon_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startsmon_at.hour.to_i && 8.hours.ago.min >= arr[$i].startsmon_at.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsmon_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endsmon_at.hour.to_i && 8.hours.ago.min <= arr[$i].endsmon_at.min.to_i) && (8.hours.ago.hour.to_i > arr[$i].startsmon_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startsmon_at2.hour.to_i && 8.hours.ago.min >= arr[$i].startsmon_at2.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsmon_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endsmon_at2.hour.to_i && 8.hours.ago.min <= arr[$i].endsmon_at2.min.to_i) && (8.hours.ago.hour.to_i >arr[$i].startsmon_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else

						if (8.hours.ago.hour.to_i > arr[$i].startsmon_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsmon_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif ((8.hours.ago.hour.to_i == arr[$i].endsmon_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endsmon_at.min.to_i)) && (8.hours.ago.hour.to_i > arr[$i].startsmon_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif ((8.hours.ago.hour.to_i == arr[$i].startsmon_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endsmon_at.min.to_i)) && (8.hours.ago.hour.to_i < arr[$i].endsmon_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						
						end
					end
				when 2
					if arr[$i].open_all_day_tues
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].closed_all_day_tues
					elsif arr[$i].second_time_tues
						if (8.hours.ago.hour.to_i > arr[$i].startstues_at.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endstues_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].startstues_at2.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endstues_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startstues_at.hour.to_i && 8.hours.ago.min >= arr[$i].startstues_at.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endstues_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endstues_at.hour.to_i && 8.hours.ago.min <= arr[$i].endstues_at.min.to_i) && (8.hours.ago.hour.to_i > arr[$i].startstues_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startstues_at2.hour.to_i && 8.hours.ago.min >= arr[$i].startstues_at2.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endstues_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endstues_at2.hour.to_i && 8.hours.ago.min <= arr[$i].endstues_at2.min.to_i) && (8.hours.ago.hour.to_i >arr[$i].startstues_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i > arr[$i].startstues_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endstues_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif ((8.hours.ago.hour.to_i == arr[$i].endstues_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endstues_at.min.to_i)) && (8.hours.ago.hour.to_i > arr[$i].startstues_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif ((8.hours.ago.hour.to_i == arr[$i].startstues_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endstues_at.min.to_i)) && (8.hours.ago.hour.to_i < arr[$i].endstues_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						
						end
					end
				when 3
					if arr[$i].open_all_day_wed
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].closed_all_day_wed
					elsif arr[$i].second_time_wed
						if (8.hours.ago.hour.to_i > arr[$i].startswed_at.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endswed_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].startswed_at2.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endswed_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startswed_at.hour.to_i && 8.hours.ago.min >= arr[$i].startswed_at.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endswed_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endswed_at.hour.to_i && 8.hours.ago.min <= arr[$i].endswed_at.min.to_i) && (8.hours.ago.hour.to_i > arr[$i].startswed_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startswed_at2.hour.to_i && 8.hours.ago.min >= arr[$i].startswed_at2.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endswed_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endswed_at2.hour.to_i && 8.hours.ago.min <= arr[$i].endswed_at2.min.to_i) && (8.hours.ago.hour.to_i >arr[$i].startswed_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i > arr[$i].startswed_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endswed_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif ((8.hours.ago.hour.to_i == arr[$i].endswed_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endswed_at.min.to_i)) && (8.hours.ago.hour.to_i > arr[$i].startswed_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif ((8.hours.ago.hour.to_i == arr[$i].startswed_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endswed_at.min.to_i)) && (8.hours.ago.hour.to_i < arr[$i].endswed_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						
						end
					end
				when 4
					if arr[$i].open_all_day_thurs
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].closed_all_day_thurs
					elsif arr[$i].second_time_thurs
						if (8.hours.ago.hour.to_i > arr[$i].startsthurs_at.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endsthurs_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].startsthurs_at2.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endsthurs_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startsthurs_at.hour.to_i && 8.hours.ago.min >= arr[$i].startsthurs_at.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsthurs_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endsthurs_at.hour.to_i && 8.hours.ago.min <= arr[$i].endsthurs_at.min.to_i) && (8.hours.ago.hour.to_i > arr[$i].startsthurs_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startsthurs_at2.hour.to_i && 8.hours.ago.min >= arr[$i].startsthurs_at2.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsthurs_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endsthurs_at2.hour.to_i && 8.hours.ago.min <= arr[$i].endsthurs_at2.min.to_i) && (8.hours.ago.hour.to_i >arr[$i].startsthurs_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i > arr[$i].startsthurs_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsthurs_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif ((8.hours.ago.hour.to_i == arr[$i].endsthurs_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endsthurs_at.min.to_i)) && (8.hours.ago.hour.to_i > arr[$i].startsthurs_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif ((8.hours.ago.hour.to_i == arr[$i].startsthurs_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endsthurs_at.min.to_i)) && (8.hours.ago.hour.to_i < arr[$i].endsthurs_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						
						end
					end
				when 5
					if arr[$i].open_all_day_fri
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].closed_all_day_fri
					elsif arr[$i].second_time_fri
						if (8.hours.ago.hour.to_i > arr[$i].startsfri_at.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endsfri_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].startsfri_at2.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endsfri_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startsfri_at.hour.to_i && 8.hours.ago.min >= arr[$i].startsfri_at.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsfri_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endsfri_at.hour.to_i && 8.hours.ago.min <= arr[$i].endsfri_at.min.to_i) && (8.hours.ago.hour.to_i > arr[$i].startsfri_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startsfri_at2.hour.to_i && 8.hours.ago.min >= arr[$i].startsfri_at2.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsfri_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endsfri_at2.hour.to_i && 8.hours.ago.min <= arr[$i].endsfri_at2.min.to_i) && (8.hours.ago.hour.to_i >arr[$i].startsfri_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i > arr[$i].startsfri_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsfri_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif ((8.hours.ago.hour.to_i == arr[$i].endsfri_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endsfri_at.min.to_i)) && (8.hours.ago.hour.to_i > arr[$i].startsfri_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif ((8.hours.ago.hour.to_i == arr[$i].startsfri_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endsfri_at.min.to_i)) && (8.hours.ago.hour.to_i < arr[$i].endsfri_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						
						end
					end
				else
					if arr[$i].open_all_day_sat
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].closed_all_day_sat
					elsif arr[$i].second_time_sat
						if (8.hours.ago.hour.to_i > arr[$i].startssat_at.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endssat_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].startssat_at2.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endssat_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startssat_at.hour.to_i && 8.hours.ago.min >= arr[$i].startssat_at.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssat_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endssat_at.hour.to_i && 8.hours.ago.min <= arr[$i].endssat_at.min.to_i) && (8.hours.ago.hour.to_i > arr[$i].startssat_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startssat_at2.hour.to_i && 8.hours.ago.min >= arr[$i].startssat_at2.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssat_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endssat_at2.hour.to_i && 8.hours.ago.min <= arr[$i].endssat_at2.min.to_i) && (8.hours.ago.hour.to_i >arr[$i].startssat_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i > arr[$i].startssat_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssat_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif ((8.hours.ago.hour.to_i == arr[$i].endssat_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endssat_at.min.to_i)) && (8.hours.ago.hour.to_i > arr[$i].startssat_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif ((8.hours.ago.hour.to_i == arr[$i].startssat_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endssat_at.min.to_i)) && (8.hours.ago.hour.to_i < arr[$i].endssat_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						
						end
					end

			end #ends case day

			$i +=1

			end #ends while loop
		elsif ((prox=="Name") && (open=="Yes"))
			arr = arr.sort_by {|f| f[:name]}

			temp_arr = Array.new
			temp_arr = arr

			$i = 0


			while $i < temp_arr.count  do

			case day
				when 0
					#in the end, temp_arr is assigned back to arr and then arr is returned
					#if the current time for a given day is less than the start time and greater than the finish time
					#that means the current facility is closed, so we delete it from temp_arr
					#!SUNDAY DONE... PICK UP AT "when 1" - test then replicate for other cases (when 1...etc)
					if arr[$i].closed_all_day_sun
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].open_all_day_sun
					elsif arr[$i].second_time_sun
						if (8.hours.ago.hour < arr[$i].startssun_at.hour.to_i) || (8.hours.ago.hour > arr[$i].endssun_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour > arr[$i].endssun_at.hour.to_i) && (8.hours.ago.hour < arr[$i].startssun_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startssun_at.hour.to_i && 8.hours.ago.min <= arr[$i].startssun_at.min.to_i) || (8.hours.ago.hour == arr[$i].endssun_at2.hour.to_i && 8.hours.ago.min >= arr[$i].endssun_at2.min.to_i) 
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endssun_at.hour.to_i && 8.hours.ago.hour == arr[$i].startssun_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endssun_at.min.to_i && 8.hours.ago.min < arr[$i].startssun_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endssun_at.hour.to_i && arr[$i].endssun_at.hour.to_i < arr[$i].startssun_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endssun_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startssun_at2.hour.to_i && arr[$i].endssun_at.hour.to_i < arr[$i].startssun_at2.hour.to_i) && (8.hours.ago.min <= arr[$i].startssun_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i < arr[$i].startssun_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].endssun_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].endssun_at.hour.to_i) && (8.hours.ago.min.to_i >= arr[$i].endssun_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].startssun_at.hour.to_i) && (8.hours.ago.min.to_i < arr[$i].endssun_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					end
				when 1
					if arr[$i].closed_all_day_mon
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].open_all_day_mon
					elsif arr[$i].second_time_mon
						if (8.hours.ago.hour < arr[$i].startsmon_at.hour.to_i) || (8.hours.ago.hour > arr[$i].endsmon_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour > arr[$i].endsmon_at.hour.to_i) && (8.hours.ago.hour < arr[$i].startsmon_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startsmon_at.hour.to_i && 8.hours.ago.min <= arr[$i].startsmon_at.min.to_i) || (8.hours.ago.hour == arr[$i].endsmon_at2.hour.to_i && 8.hours.ago.min >= arr[$i].endsmon_at2.min.to_i) 
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endsmon_at.hour.to_i && 8.hours.ago.hour == arr[$i].startsmon_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endsmon_at.min.to_i && 8.hours.ago.min < arr[$i].startsmon_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endsmon_at.hour.to_i && arr[$i].endsmon_at.hour.to_i < arr[$i].startsmon_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endsmon_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startsmon_at2.hour.to_i && arr[$i].endsmon_at.hour.to_i < arr[$i].startsmon_at2.hour.to_i) && (8.hours.ago.min <= arr[$i].startsmon_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i < arr[$i].startsmon_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].endsmon_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].endsmon_at.hour.to_i) && (8.hours.ago.min.to_i >= arr[$i].endsmon_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].startsmon_at.hour.to_i) && (8.hours.ago.min.to_i < arr[$i].endsmon_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					end
				when 2
					if arr[$i].closed_all_day_tues
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].open_all_day_tues
					elsif arr[$i].second_time_tues
						if (8.hours.ago.hour < arr[$i].startstues_at.hour.to_i) || (8.hours.ago.hour > arr[$i].endstues_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour > arr[$i].endstues_at.hour.to_i) && (8.hours.ago.hour < arr[$i].startstues_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startstues_at.hour.to_i && 8.hours.ago.min <= arr[$i].startstues_at.min.to_i) || (8.hours.ago.hour == arr[$i].endstues_at2.hour.to_i && 8.hours.ago.min >= arr[$i].endstues_at2.min.to_i) 
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endstues_at.hour.to_i && 8.hours.ago.hour == arr[$i].startstues_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endstues_at.min.to_i && 8.hours.ago.min < arr[$i].startstues_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endstues_at.hour.to_i && arr[$i].endstues_at.hour.to_i < arr[$i].startstues_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endstues_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startstues_at2.hour.to_i && arr[$i].endstues_at.hour.to_i < arr[$i].startstues_at2.hour.to_i) && (8.hours.ago.min <= arr[$i].startstues_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i < arr[$i].startstues_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].endstues_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].endstues_at.hour.to_i) && (8.hours.ago.min.to_i >= arr[$i].endstues_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].startstues_at.hour.to_i) && (8.hours.ago.min.to_i < arr[$i].endstues_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					end
				when 3
					if arr[$i].closed_all_day_wed
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].open_all_day_wed
					elsif arr[$i].second_time_wed
						if (8.hours.ago.hour < arr[$i].startswed_at.hour.to_i) || (8.hours.ago.hour > arr[$i].endswed_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour > arr[$i].endswed_at.hour.to_i) && (8.hours.ago.hour < arr[$i].startswed_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startswed_at.hour.to_i && 8.hours.ago.min <= arr[$i].startswed_at.min.to_i) || (8.hours.ago.hour == arr[$i].endswed_at2.hour.to_i && 8.hours.ago.min >= arr[$i].endswed_at2.min.to_i) 
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endswed_at.hour.to_i && 8.hours.ago.hour == arr[$i].startswed_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endswed_at.min.to_i && 8.hours.ago.min < arr[$i].startswed_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endswed_at.hour.to_i && arr[$i].endswed_at.hour.to_i < arr[$i].startswed_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endswed_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startswed_at2.hour.to_i && arr[$i].endswed_at.hour.to_i < arr[$i].startswed_at2.hour.to_i) && (8.hours.ago.min <= arr[$i].startswed_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i < arr[$i].startswed_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].endswed_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].endswed_at.hour.to_i) && (8.hours.ago.min.to_i >= arr[$i].endswed_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].startswed_at.hour.to_i) && (8.hours.ago.min.to_i < arr[$i].endswed_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					end
				when 4
					if arr[$i].closed_all_day_thurs
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].open_all_day_thurs
					elsif arr[$i].second_time_thurs
						if (8.hours.ago.hour < arr[$i].startsthurs_at.hour.to_i) || (8.hours.ago.hour > arr[$i].endsthurs_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour > arr[$i].endsthurs_at.hour.to_i) && (8.hours.ago.hour < arr[$i].startsthurs_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startsthurs_at.hour.to_i && 8.hours.ago.min <= arr[$i].startsthurs_at.min.to_i) || (8.hours.ago.hour == arr[$i].endsthurs_at2.hour.to_i && 8.hours.ago.min >= arr[$i].endsthurs_at2.min.to_i) 
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endsthurs_at.hour.to_i && 8.hours.ago.hour == arr[$i].startsthurs_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endsthurs_at.min.to_i && 8.hours.ago.min < arr[$i].startsthurs_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endsthurs_at.hour.to_i && arr[$i].endsthurs_at.hour.to_i < arr[$i].startsthurs_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endsthurs_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startsthurs_at2.hour.to_i && arr[$i].endsthurs_at.hour.to_i < arr[$i].startsthurs_at2.hour.to_i) && (8.hours.ago.min <= arr[$i].startsthurs_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i < arr[$i].startsthurs_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].endsthurs_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].endsthurs_at.hour.to_i) && (8.hours.ago.min.to_i >= arr[$i].endsthurs_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].startsthurs_at.hour.to_i) && (8.hours.ago.min.to_i < arr[$i].endsthurs_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					end
				when 5
					if arr[$i].closed_all_day_fri
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].open_all_day_fri
					elsif arr[$i].second_time_fri
						if (8.hours.ago.hour < arr[$i].startsfri_at.hour.to_i) || (8.hours.ago.hour > arr[$i].endsfri_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour > arr[$i].endsfri_at.hour.to_i) && (8.hours.ago.hour < arr[$i].startsfri_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startsfri_at.hour.to_i && 8.hours.ago.min <= arr[$i].startsfri_at.min.to_i) || (8.hours.ago.hour == arr[$i].endsfri_at2.hour.to_i && 8.hours.ago.min >= arr[$i].endsfri_at2.min.to_i) 
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endsfri_at.hour.to_i && 8.hours.ago.hour == arr[$i].startsfri_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endsfri_at.min.to_i && 8.hours.ago.min < arr[$i].startsfri_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endsfri_at.hour.to_i && arr[$i].endsfri_at.hour.to_i < arr[$i].startsfri_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endsfri_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startsfri_at2.hour.to_i && arr[$i].endsfri_at.hour.to_i < arr[$i].startsfri_at2.hour.to_i) && (8.hours.ago.min <= arr[$i].startsfri_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i < arr[$i].startsfri_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].endsfri_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].endsfri_at.hour.to_i) && (8.hours.ago.min.to_i >= arr[$i].endsfri_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].startsfri_at.hour.to_i) && (8.hours.ago.min.to_i < arr[$i].endsfri_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					end
				else
					if arr[$i].closed_all_day_sat
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].open_all_day_sat
					elsif arr[$i].second_time_sat
						if (8.hours.ago.hour < arr[$i].startssat_at.hour.to_i) || (8.hours.ago.hour > arr[$i].endssat_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour > arr[$i].endssat_at.hour.to_i) && (8.hours.ago.hour < arr[$i].startssat_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startssat_at.hour.to_i && 8.hours.ago.min <= arr[$i].startssat_at.min.to_i) || (8.hours.ago.hour == arr[$i].endssat_at2.hour.to_i && 8.hours.ago.min >= arr[$i].endssat_at2.min.to_i) 
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endssat_at.hour.to_i && 8.hours.ago.hour == arr[$i].startssat_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endssat_at.min.to_i && 8.hours.ago.min < arr[$i].startssat_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].endssat_at.hour.to_i && arr[$i].endssat_at.hour.to_i < arr[$i].startssat_at2.hour.to_i) && (8.hours.ago.min >= arr[$i].endssat_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour == arr[$i].startssat_at2.hour.to_i && arr[$i].endssat_at.hour.to_i < arr[$i].startssat_at2.hour.to_i) && (8.hours.ago.min <= arr[$i].startssat_at2.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i < arr[$i].startssat_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].endssat_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].endssat_at.hour.to_i) && (8.hours.ago.min.to_i >= arr[$i].endssat_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif (8.hours.ago.hour.to_i == arr[$i].startssat_at.hour.to_i) && (8.hours.ago.min.to_i < arr[$i].endssat_at.min.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					end

			end #ends case day

			$i +=1

			end #ends while loop


		elsif ((prox=="Name") && (open=="No"))
			arr = arr.sort_by {|f| f[:name]}

			temp_arr = Array.new
			temp_arr = arr

			$i = 0

			while $i < temp_arr.count  do

			case day
				when 0
					if arr[$i].open_all_day_sun
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].closed_all_day_sun
					elsif arr[$i].second_time_sun
						if (8.hours.ago.hour.to_i > arr[$i].startssun_at.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endssun_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].startssun_at2.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endssun_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startssun_at.hour.to_i && 8.hours.ago.min >= arr[$i].startssun_at.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssun_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endssun_at.hour.to_i && 8.hours.ago.min <= arr[$i].endssun_at.min.to_i) && (8.hours.ago.hour.to_i > arr[$i].startssun_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startssun_at2.hour.to_i && 8.hours.ago.min >= arr[$i].startssun_at2.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssun_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endssun_at2.hour.to_i && 8.hours.ago.min <= arr[$i].endssun_at2.min.to_i) && (8.hours.ago.hour.to_i >arr[$i].startssun_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else

						if (8.hours.ago.hour.to_i > arr[$i].startssun_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssun_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif ((8.hours.ago.hour.to_i == arr[$i].endssun_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endssun_at.min.to_i)) && (8.hours.ago.hour.to_i > arr[$i].startssun_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif ((8.hours.ago.hour.to_i == arr[$i].startssun_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endssun_at.min.to_i)) && (8.hours.ago.hour.to_i < arr[$i].endssun_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						
						end
					end
				when 1
					if arr[$i].open_all_day_mon
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].closed_all_day_mon
					elsif arr[$i].second_time_mon
						if (8.hours.ago.hour.to_i > arr[$i].startsmon_at.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endsmon_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].startsmon_at2.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endsmon_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startsmon_at.hour.to_i && 8.hours.ago.min >= arr[$i].startsmon_at.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsmon_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endsmon_at.hour.to_i && 8.hours.ago.min <= arr[$i].endsmon_at.min.to_i) && (8.hours.ago.hour.to_i > arr[$i].startsmon_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startsmon_at2.hour.to_i && 8.hours.ago.min >= arr[$i].startsmon_at2.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsmon_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endsmon_at2.hour.to_i && 8.hours.ago.min <= arr[$i].endsmon_at2.min.to_i) && (8.hours.ago.hour.to_i >arr[$i].startsmon_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else

						if (8.hours.ago.hour.to_i > arr[$i].startsmon_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsmon_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif ((8.hours.ago.hour.to_i == arr[$i].endsmon_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endsmon_at.min.to_i)) && (8.hours.ago.hour.to_i > arr[$i].startsmon_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif ((8.hours.ago.hour.to_i == arr[$i].startsmon_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endsmon_at.min.to_i)) && (8.hours.ago.hour.to_i < arr[$i].endsmon_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						
						end
					end
				when 2
					if arr[$i].open_all_day_tues
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].closed_all_day_tues
					elsif arr[$i].second_time_tues
						if (8.hours.ago.hour.to_i > arr[$i].startstues_at.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endstues_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].startstues_at2.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endstues_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startstues_at.hour.to_i && 8.hours.ago.min >= arr[$i].startstues_at.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endstues_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endstues_at.hour.to_i && 8.hours.ago.min <= arr[$i].endstues_at.min.to_i) && (8.hours.ago.hour.to_i > arr[$i].startstues_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startstues_at2.hour.to_i && 8.hours.ago.min >= arr[$i].startstues_at2.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endstues_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endstues_at2.hour.to_i && 8.hours.ago.min <= arr[$i].endstues_at2.min.to_i) && (8.hours.ago.hour.to_i >arr[$i].startstues_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i > arr[$i].startstues_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endstues_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif ((8.hours.ago.hour.to_i == arr[$i].endstues_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endstues_at.min.to_i)) && (8.hours.ago.hour.to_i > arr[$i].startstues_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif ((8.hours.ago.hour.to_i == arr[$i].startstues_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endstues_at.min.to_i)) && (8.hours.ago.hour.to_i < arr[$i].endstues_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						
						end
					end
				when 3
					if arr[$i].open_all_day_wed
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].closed_all_day_wed
					elsif arr[$i].second_time_wed
						if (8.hours.ago.hour.to_i > arr[$i].startswed_at.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endswed_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].startswed_at2.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endswed_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startswed_at.hour.to_i && 8.hours.ago.min >= arr[$i].startswed_at.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endswed_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endswed_at.hour.to_i && 8.hours.ago.min <= arr[$i].endswed_at.min.to_i) && (8.hours.ago.hour.to_i > arr[$i].startswed_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startswed_at2.hour.to_i && 8.hours.ago.min >= arr[$i].startswed_at2.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endswed_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endswed_at2.hour.to_i && 8.hours.ago.min <= arr[$i].endswed_at2.min.to_i) && (8.hours.ago.hour.to_i >arr[$i].startswed_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i > arr[$i].startswed_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endswed_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif ((8.hours.ago.hour.to_i == arr[$i].endswed_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endswed_at.min.to_i)) && (8.hours.ago.hour.to_i > arr[$i].startswed_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif ((8.hours.ago.hour.to_i == arr[$i].startswed_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endswed_at.min.to_i)) && (8.hours.ago.hour.to_i < arr[$i].endswed_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						
						end
					end
				when 4
					if arr[$i].open_all_day_thurs
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].closed_all_day_thurs
					elsif arr[$i].second_time_thurs
						if (8.hours.ago.hour.to_i > arr[$i].startsthurs_at.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endsthurs_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].startsthurs_at2.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endsthurs_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startsthurs_at.hour.to_i && 8.hours.ago.min >= arr[$i].startsthurs_at.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsthurs_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endsthurs_at.hour.to_i && 8.hours.ago.min <= arr[$i].endsthurs_at.min.to_i) && (8.hours.ago.hour.to_i > arr[$i].startsthurs_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startsthurs_at2.hour.to_i && 8.hours.ago.min >= arr[$i].startsthurs_at2.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsthurs_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endsthurs_at2.hour.to_i && 8.hours.ago.min <= arr[$i].endsthurs_at2.min.to_i) && (8.hours.ago.hour.to_i >arr[$i].startsthurs_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i > arr[$i].startsthurs_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsthurs_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif ((8.hours.ago.hour.to_i == arr[$i].endsthurs_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endsthurs_at.min.to_i)) && (8.hours.ago.hour.to_i > arr[$i].startsthurs_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif ((8.hours.ago.hour.to_i == arr[$i].startsthurs_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endsthurs_at.min.to_i)) && (8.hours.ago.hour.to_i < arr[$i].endsthurs_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						
						end
					end
				when 5
					if arr[$i].open_all_day_fri
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].closed_all_day_fri
					elsif arr[$i].second_time_fri
						if (8.hours.ago.hour.to_i > arr[$i].startsfri_at.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endsfri_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].startsfri_at2.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endsfri_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startsfri_at.hour.to_i && 8.hours.ago.min >= arr[$i].startsfri_at.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsfri_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endsfri_at.hour.to_i && 8.hours.ago.min <= arr[$i].endsfri_at.min.to_i) && (8.hours.ago.hour.to_i > arr[$i].startsfri_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startsfri_at2.hour.to_i && 8.hours.ago.min >= arr[$i].startsfri_at2.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsfri_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endsfri_at2.hour.to_i && 8.hours.ago.min <= arr[$i].endsfri_at2.min.to_i) && (8.hours.ago.hour.to_i >arr[$i].startsfri_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i > arr[$i].startsfri_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsfri_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif ((8.hours.ago.hour.to_i == arr[$i].endsfri_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endsfri_at.min.to_i)) && (8.hours.ago.hour.to_i > arr[$i].startsfri_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif ((8.hours.ago.hour.to_i == arr[$i].startsfri_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endsfri_at.min.to_i)) && (8.hours.ago.hour.to_i < arr[$i].endsfri_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						
						end
					end
				else
					if arr[$i].open_all_day_sat
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif arr[$i].closed_all_day_sat
					elsif arr[$i].second_time_sat
						if (8.hours.ago.hour.to_i > arr[$i].startssat_at.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endssat_at.hour.to_i) || (8.hours.ago.hour.to_i > arr[$i].startssat_at2.hour.to_i && 8.hours.ago.hour.to_i < arr[$i].endssat_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startssat_at.hour.to_i && 8.hours.ago.min >= arr[$i].startssat_at.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssat_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endssat_at.hour.to_i && 8.hours.ago.min <= arr[$i].endssat_at.min.to_i) && (8.hours.ago.hour.to_i > arr[$i].startssat_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].startssat_at2.hour.to_i && 8.hours.ago.min >= arr[$i].startssat_at2.min.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssat_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif (8.hours.ago.hour.to_i == arr[$i].endssat_at2.hour.to_i && 8.hours.ago.min <= arr[$i].endssat_at2.min.to_i) && (8.hours.ago.hour.to_i >arr[$i].startssat_at2.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						end
					else
						if (8.hours.ago.hour.to_i > arr[$i].startssat_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssat_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						elsif ((8.hours.ago.hour.to_i == arr[$i].endssat_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endssat_at.min.to_i)) && (8.hours.ago.hour.to_i > arr[$i].startssat_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1

						elsif ((8.hours.ago.hour.to_i == arr[$i].startssat_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endssat_at.min.to_i)) && (8.hours.ago.hour.to_i < arr[$i].endssat_at.hour.to_i)
							t = arr[$i]
							temp_arr.delete(t)
							$i-=1
						
						end
					end

			end #ends case day

			$i +=1

			end #ends while loop
		end #ends if block
		arr = temp_arr
	  	return arr
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

def self.power(num, pow)
	num ** pow
end

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





end #ends class
