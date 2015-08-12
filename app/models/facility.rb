require 'bigdecimal'
require 'bigdecimal/util'

class Facility < ActiveRecord::Base

	validates :name, :lat, :long, :services, presence: true

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



			#after bubble_sort, arr[0] is Aachen Token, arr[1] is UBCLE2, and arr[2] is Alabama
			#the problem: after Aachen Token goes through, UBCLE2 does not enter the arr.each loop even though Alabama does.
			#for some reason i'm getting a null pointer when i hit UBCLE2 in the while loop. Alabama executes find though.


			temp_arr = Array.new
			temp_arr = arr

			$i = 0

			while $i < temp_arr.count  do

			case day
				when 0
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
				when 1
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
				when 2
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
				when 3
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
				when 4
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
				when 5
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
					if (8.hours.ago.hour.to_i > arr[$i].startssun_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssun_at.hour.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].endssun_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endssun_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].startssun_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endssun_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					end
				when 1
					if (8.hours.ago.hour.to_i > arr[$i].startsmon_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsmon_at.hour.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].endsmon_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endsmon_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].startsmon_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endsmon_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					end
				when 2
					if (8.hours.ago.hour.to_i > arr[$i].startstues_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endstues_at.hour.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].endstues_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endstues_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].startstues_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endstues_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					end
				when 3

					if (8.hours.ago.hour.to_i > arr[$i].startswed_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endswed_at.hour.to_i)

						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].endswed_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endswed_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].startswed_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endswed_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					end
				when 4
					if (8.hours.ago.hour.to_i > arr[$i].startsthurs_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsthurs_at.hour.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].endsthurs_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endsthurs_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].startsthurs_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endsthurs_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					end
				when 5
					if (8.hours.ago.hour.to_i > arr[$i].startsfri_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsfri_at.hour.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].endsfri_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endsfri_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].startsfri_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endsfri_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					end
				else
					if (8.hours.ago.hour.to_i > arr[$i].startssat_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssat_at.hour.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].endssat_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endssat_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].startssat_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endssat_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
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
				when 1
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
				when 2
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
				when 3

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
				when 4
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
				when 5
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
					if (8.hours.ago.hour.to_i > arr[$i].startssun_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssun_at.hour.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].endssun_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endssun_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].startssun_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endssun_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					end
				when 1
					if (8.hours.ago.hour.to_i > arr[$i].startsmon_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsmon_at.hour.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].endsmon_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endsmon_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].startsmon_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endsmon_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					end
				when 2
					if (8.hours.ago.hour.to_i > arr[$i].startstues_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endstues_at.hour.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].endstues_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endstues_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].startstues_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endstues_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					end
				when 3
					if (8.hours.ago.hour.to_i > arr[$i].startswed_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endswed_at.hour.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].endswed_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endswed_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].startswed_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endswed_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					end
				when 4
					if (8.hours.ago.hour.to_i > arr[$i].startsthurs_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsthurs_at.hour.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].endsthurs_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endsthurs_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].startsthurs_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endsthurs_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					end
				when 5
					if (8.hours.ago.hour.to_i > arr[$i].startsfri_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endsfri_at.hour.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].endsfri_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endsfri_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].startsfri_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endsfri_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					end
				else
					if (8.hours.ago.hour.to_i > arr[$i].startssat_at.hour.to_i) && (8.hours.ago.hour.to_i < arr[$i].endssat_at.hour.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].endssat_at.hour.to_i) && (8.hours.ago.min.to_i <= arr[$i].endssat_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
					elsif (8.hours.ago.hour.to_i == arr[$i].startssat_at.hour.to_i) && (8.hours.ago.min.to_i > arr[$i].endssat_at.min.to_i)
						t = arr[$i]
						temp_arr.delete(t)
						$i-=1
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
