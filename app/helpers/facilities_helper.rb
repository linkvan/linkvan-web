module FacilitiesHelper

	def display_mon_hours(facility)
		if !facility.open_all_day_mon.nil? && facility.open_all_day_mon
			content_tag(:h5, "OPEN", class: "food-colour")
		elsif !facility.closed_all_day_mon.nil? && facility.closed_all_day_mon
			content_tag(:h5, "CLOSED", class: "medical-colour")
		elsif facility.closed_all_day_mon.nil? && facility.closed_all_day_mon.nil?
			content_tag(:h5, "BOTH ARE NIL")
		elsif facility.second_time_mon
			content_tag(:h5, facility.startsmon_at.strftime("%I:%M%p") + " to " + facility.endsmon_at.strftime("%I:%M%p") + " and " + facility.startsmon_at2.strftime("%I:%M%p") + " to " + facility.endsmon_at2.strftime("%I:%M%p"))
		else
			content_tag(:h5, facility.startsmon_at.strftime("%I:%M%p") + " to " + facility.endsmon_at.strftime("%I:%M%p"))
		end
	end

	def display_tues_hours(facility)
		if !facility.open_all_day_tues.nil? && facility.open_all_day_tues
			content_tag(:h5, "OPEN", class: "food-colour")
		elsif !facility.closed_all_day_tues.nil? && facility.closed_all_day_tues
			content_tag(:h5, "CLOSED", class: "medical-colour")
		elsif facility.closed_all_day_tues.nil? && facility.closed_all_day_tues.nil?
			content_tag(:h5, "BOTH ARE NIL")
		elsif facility.second_time_tues
			content_tag(:h5, facility.startstues_at.strftime("%I:%M%p") + " to " + facility.endstues_at.strftime("%I:%M%p") + " and " + facility.startstues_at2.strftime("%I:%M%p") + " to " + facility.endstues_at2.strftime("%I:%M%p"))
		else
			content_tag(:h5, facility.startstues_at.strftime("%I:%M%p") + " to " + facility.endstues_at.strftime("%I:%M%p"))
		end
	end

	def display_wed_hours(facility)
		if !facility.open_all_day_wed.nil? && facility.open_all_day_wed
			content_tag(:h5, "OPEN", class: "food-colour")
		elsif !facility.closed_all_day_wed.nil? && facility.closed_all_day_wed
			content_tag(:h5, "CLOSED", class: "medical-colour")
		elsif facility.closed_all_day_wed.nil? && facility.closed_all_day_wed.nil?
			content_tag(:h5, "BOTH ARE NIL")
		elsif facility.second_time_wed
			content_tag(:h5, facility.startswed_at.strftime("%I:%M%p") + " to " + facility.endswed_at.strftime("%I:%M%p") + " and " + facility.startswed_at2.strftime("%I:%M%p") + " to " + facility.endswed_at2.strftime("%I:%M%p"))
		else
			content_tag(:h5, facility.startswed_at.strftime("%I:%M%p") + " to " + facility.endswed_at.strftime("%I:%M%p"))
		end
	end

	def display_thurs_hours(facility)
		if !facility.open_all_day_thurs.nil? && facility.open_all_day_thurs
			content_tag(:h5, "OPEN", class: "food-colour")
		elsif !facility.closed_all_day_thurs.nil? && facility.closed_all_day_thurs
			content_tag(:h5, "CLOSED", class: "medical-colour")
		elsif facility.closed_all_day_thurs.nil? && facility.closed_all_day_thurs.nil?
			content_tag(:h5, "BOTH ARE NIL")
		elsif facility.second_time_thurs
			content_tag(:h5, facility.startsthurs_at.strftime("%I:%M%p") + " to " + facility.endsthurs_at.strftime("%I:%M%p") + " and " + facility.startsthurs_at2.strftime("%I:%M%p") + " to " + facility.endsthurs_at2.strftime("%I:%M%p"))
		else
			content_tag(:h5, facility.startsthurs_at.strftime("%I:%M%p") + " to " + facility.endsthurs_at.strftime("%I:%M%p"))
		end
	end

	def display_fri_hours(facility)
		if !facility.open_all_day_fri.nil? && facility.open_all_day_fri
			content_tag(:h5, "OPEN", class: "food-colour")
		elsif !facility.closed_all_day_fri.nil? && facility.closed_all_day_fri
			content_tag(:h5, "CLOSED", class: "medical-colour")
		elsif facility.closed_all_day_fri.nil? && facility.closed_all_day_fri.nil?
			content_tag(:h5, "BOTH ARE NIL")
		elsif facility.second_time_fri
			content_tag(:h5, facility.startsfri_at.strftime("%I:%M%p") + " to " + facility.endsfri_at.strftime("%I:%M%p") + " and " + facility.startsfri_at2.strftime("%I:%M%p") + " to " + facility.endsfri_at2.strftime("%I:%M%p"))
		else
			content_tag(:h5, facility.startsfri_at.strftime("%I:%M%p") + " to " + facility.endsfri_at.strftime("%I:%M%p"))
		end
	end

	def display_sat_hours(facility)
		if !facility.open_all_day_sat.nil? && facility.open_all_day_sat
			content_tag(:h5, "OPEN", class: "food-colour")
		elsif !facility.closed_all_day_sat.nil? && facility.closed_all_day_sat
			content_tag(:h5, "CLOSED", class: "medical-colour")
		elsif facility.closed_all_day_sat.nil? && facility.closed_all_day_sat.nil?
			content_tag(:h5, "BOTH ARE NIL")
		elsif facility.second_time_sat
			content_tag(:h5, facility.startssat_at.strftime("%I:%M%p") + " to " + facility.endssat_at.strftime("%I:%M%p") + " and " + facility.startssat_at2.strftime("%I:%M%p") + " to " + facility.endssat_at2.strftime("%I:%M%p"))
		else
			content_tag(:h5, facility.startssat_at.strftime("%I:%M%p") + " to " + facility.endssat_at.strftime("%I:%M%p"))
		end
	end

	def display_sun_hours(facility)
		if !facility.open_all_day_sun.nil? && facility.open_all_day_sun
			content_tag(:h5, "OPEN", class: "food-colour")
		elsif !facility.closed_all_day_sun.nil? && facility.closed_all_day_sun
			content_tag(:h5, "CLOSED", class: "medical-colour")
		elsif facility.closed_all_day_sun.nil? && facility.closed_all_day_sun.nil?
			content_tag(:h5, "BOTH ARE NIL")
		elsif facility.second_time_sun
			content_tag(:h5, facility.startssun_at.strftime("%I:%M%p") + " to " + facility.endssun_at.strftime("%I:%M%p") + " and " + facility.startssun_at2.strftime("%I:%M%p") + " to " + facility.endssun_at2.strftime("%I:%M%p"))
		else
			content_tag(:h5, facility.startssun_at.strftime("%I:%M%p") + " to " + facility.endssun_at.strftime("%I:%M%p"))
		end
	end

	def display_services(services_str)
		content_arr = ""
		services_arr = services_str.split(" ")
		services_arr.each do |s|
			case s
			when "Shelter"
					content_arr += content_tag(:i, inline_svg('icons/shelter.svg', size: '30px'), class: "linkvan-icon service", id: "Shelter")
   			when "Food"
   				content_arr += content_tag(:i, inline_svg('icons/cutlery.svg', size: '30px'), class: "linkvan-icon service", id: "Food")
   			when "Medical"
   				content_arr += content_tag(:i, inline_svg('icons/medical.svg', size: '30px'), class: "linkvan-icon service", id: "Medical")
   			when "Hygiene"
   				content_arr += content_tag(:i, inline_svg('icons/hygiene.svg', size: '30px'), class: "linkvan-icon service", id: "Hygiene")
   			when "Technology"
					content_arr += content_tag(:i, inline_svg('icons/technology.svg', size: '30px'), class: "linkvan-icon service", id: "Technology")
				when "Legal"
					content_arr += content_tag(:i, inline_svg('icons/advocacy.svg', size: '30px'), class: "linkvan-icon service", id: "Legal")
				when "Learning"
					content_arr += content_tag(:i, inline_svg('icons/learning.svg', size: '30px'), class: "linkvan-icon service", id: "Learning")
				when "Training_Services"
					content_arr += content_tag(:i, inline_svg('icons/crisis.svg', size: '30px'), class: "linkvan-icon service", id: "Training")
				when "Overdose_Prevention"
					content_arr += content_tag(:i, inline_svg('icons/overdose-prevention.svg', size: '30px'), class: "linkvan-icon service", id: "Overdose_Prevention")
				when "Phone"
					content_arr += content_tag(:i, inline_svg('icons/phone.svg', size: '30px'), class: "linkvan-icon service", id: "Phone")
				when "Water_Fountain"
					content_arr += content_tag(:i, inline_svg('icons/water-fountains.svg', size: '30px'), class: "linkvan-icon service", id: "Phone")
				#else add error case?
			end #ends case
		end

		return content_arr.html_safe
	end

	def format_tel(tel)
		if (tel[0] == "+")
			return tel.gsub("+1", "")
		else
			if (tel[0] != "1")
				tel.prepend("+1")
			end
			return tel.delete('-').gsub(/\s+/, "")
		end

	end

	def correct_user_or_admin?
		if current_user.nil?
			return false
		else
			if current_user.admin?
				return true
			else
				current_user.facilities.each do |f|
					if f.id == Facility.find(params[:id]).id
						return true
					end
				end
				return false
			end
		end
	end

	def willCloseSoon(facility)
		columnByDay = {}
		columnByDay['Mon'] = ['endsmon_at', 'open_all_day_mon']
		columnByDay['Tue'] = ['endstues_at', 'open_all_day_tues']
		columnByDay['Wed'] = ['endswed_at', 'open_all_day_wed']
		columnByDay['Thu'] = ['endsthurs_at', 'open_all_day_thurs']
		columnByDay['Fri'] = ['endsfri_at', 'open_all_day_fri']
		columnByDay['Sat'] = ['endssat_at', 'open_all_day_sat']
		columnByDay['Sun'] = ['endssun_at', 'open_all_day_sun']
		currentDay = Time.new.in_time_zone("Pacific Time (US & Canada)").strftime('%a')
		currentTime = Time.new.in_time_zone("Pacific Time (US & Canada)")
		fEndTime = facility[columnByDay[currentDay][0]]
		convertedUserTime = 		Time.utc(2000, 01, 01, currentTime.hour, currentTime.min, 0)
		convertedFacilityTime = Time.utc(2000, 01, 01, fEndTime.hour, fEndTime.min, 0)
		
		if facility[columnByDay[currentDay][1]]
			return false
		end

		# If it will close in 30 minutes
		if (0..30).include? ((convertedFacilityTime.to_i - convertedUserTime.to_i) / 60)
			return true
		end

		return false
	end

	def willOpenSoon(facility)
		columnByDay = {}
		columnByDay['Mon'] = ['startsmon_at', 'closed_all_day_mon']
		columnByDay['Tue'] = ['startstues_at', 'closed_all_day_tues']
		columnByDay['Wed'] = ['startswed_at', 'closed_all_day_wed']
		columnByDay['Thu'] = ['startsthurs_at', 'closed_all_day_thurs']
		columnByDay['Fri'] = ['startsfri_at', 'closed_all_day_fri']
		columnByDay['Sat'] = ['startssat_at', 'closed_all_day_sat']
		columnByDay['Sun'] = ['startssun_at', 'closed_all_day_sun']
		currentDay = Time.new.in_time_zone("Pacific Time (US & Canada)").strftime('%a')
		currentTime = Time.new.in_time_zone("Pacific Time (US & Canada)")
		fStartTime = facility[columnByDay[currentDay][0]]
		convertedUserTime = 		Time.utc(2000, 01, 01, currentTime.hour, currentTime.min, 0)
		convertedFacilityTime = Time.utc(2000, 01, 01, fStartTime.hour, fStartTime.min, 0)

		if facility[columnByDay[currentDay][1]]
			return false
		end

		# If it will open in 30 minutes
		if (0..30).include? ((convertedFacilityTime.to_i - convertedUserTime.to_i) / 60)
			return true
		end

		return false
	end

	def isWelcome(category, welcomesArray)
		return welcomesArray.include?(category) || welcomesArray.include?("all")
	end
	
end

