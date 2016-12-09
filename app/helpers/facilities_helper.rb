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
					content_arr += content_tag(:i, inline_svg('icons/shelter.svg', size: '25px'), class: "linkvan-icon service", id: "Shelter", onclick: "moreInfo('shelter');")
   			when "Food"
   				content_arr += content_tag(:i, inline_svg('icons/cutlery.svg', size: '25px'), class: "linkvan-icon service", id: "Food", onclick: "moreInfo('food');")
   			when "Medical"
   				content_arr += content_tag(:i, inline_svg('icons/medical.svg', size: '25px'), class: "linkvan-icon service", id: "Medical", onclick: "moreInfo('medical');")
   			when "Hygiene"
   				content_arr += content_tag(:i, inline_svg('icons/hygiene.svg', size: '25px'), class: "linkvan-icon service", id: "Hygiene", onclick: "moreInfo('hygiene');")
   			when "Technology"
					content_arr += content_tag(:i, inline_svg('icons/technology.svg', size: '25px'), class: "linkvan-icon service", id: "Technology", onclick: "moreInfo('technology');")
				when "Legal"
					content_arr += content_tag(:i, inline_svg('icons/advocacy.svg', size: '25px'), class: "linkvan-icon service", id: "Legal", onclick: "moreInfo('legal');")
				when "Learning"
					content_arr += content_tag(:i, inline_svg('icons/learning.svg', size: '25px'), class: "linkvan-icon service", id: "Learning", onclick: "moreInfo('learning');")
				when "Training_Services"
					content_arr += content_tag(:i, inline_svg('icons/crisis.svg', size: '25px'), class: "linkvan-icon service", id: "Training",  onclick: "moreInfo('training');")
				#else add error case?
			end #ends case
		end

		return content_arr.html_safe
	end


	def resource_t_or_f?(t_or_f)
		if t_or_f
			content_tag(:i, nil, class: "glyphicon glyphicon-ok food-colour")
		else
			content_tag(:i, nil, class: "glyphicon glyphicon-remove medical-colour")
		end
	end

	def resource_icon_t_or_f?(res, t_or_f)
		case res
		when "id"
			if t_or_f
				content_tag(:i, inline_svg('icons/idcard.svg', size: '24px'), class: "linkvan-icon")
			else
				content_tag(:i, inline_svg('icons/idcard.svg', size: '24px'), class: "linkvan-icon")
			end
		when "pets"
			if t_or_f
				content_tag(:i, inline_svg('icons/pawprint.svg', size: '24px'), class: "linkvan-icon")
			else
				content_tag(:i, inline_svg('icons/pawprint.svg', size: '24px'), class: "linkvan-icon")
			end
		when "cart"
			if t_or_f
				content_tag(:i, inline_svg('icons/cart.svg', size: '24px'), class: "linkvan-icon")
			else
				content_tag(:i, inline_svg('icons/cart.svg', size: '24px'), class: "linkvan-icon")
			end
		when "phone"
			if t_or_f
				content_tag(:i, inline_svg('icons/phone.svg', size: '24px'), class: "linkvan-icon")
			else
				content_tag(:i, inline_svg('icons/phone.svg', size: '24px'), class: "linkvan-icon")
			end
		else
			if t_or_f
				content_tag(:i, inline_svg('icons/wifi.svg', size: '24px'), class: "linkvan-icon")
			else
				content_tag(:i, inline_svg('icons/wifi.svg', size: '24px'), class: "linkvan-icon")
			end
		end
	end

	def resource_text_t_or_f?(res, t_or_f)
		case res
		when "id"
			if t_or_f
				content_tag(:h5, "ID IS required")
			else
				content_tag(:h5, "ID IS NOT required")
			end
		when "pets"
			if t_or_f
				content_tag(:h5, "Pets ARE allowed")
			else
				content_tag(:h5, "Pets ARE NOT allowed")
			end
		when "cart"
			if t_or_f
				content_tag(:h5, "Shopping carts ARE allowed")
			else
				content_tag(:h5, "Shopping carts ARE NOT allowed")
			end
		when "phone"
			if t_or_f
				content_tag(:h5, "Phones ARE available")
			else
				content_tag(:h5, "Phones ARE NOT available")
			end
		else
			if t_or_f
				content_tag(:h5, "Wi-Fi IS available")
			else
				content_tag(:h5, "Wi-Fi IS NOT available")
			end
		end
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

	def isKeyword
		@word = params[:search]
		@word = @word.strip
		@word = @word.downcase
		case @word
		when "child", "children", "youth", "youths", "adult", "adults", "senior", "seniors", "suitability", "shelter", "house", "housing", "food", "medical", "hygiene", "clean", "cleaning", "shower", "technology", "computer", "tech", "legal", "law", "learning", "learn", "education", "teaching", "teach", "teacher", "all", "facility", "facilities"
			return true
		else
			return false
		end
	end

	def getKeyword(word)
		@word = word
		@word = @word.strip
		@word = @word.downcase
		case @word
		when "children", "child"
			return @word = "children"
		when "youth", "youths"
			return @word = "youth"
		when "adult", "adults"
			return @word = "adult"
		when "senior", "seniors"
			return @word = "senior"
		when "shelter", "house", "housing"
			return @word = "Shelter"
		when "food"
			return @word = "Food"
		when "medical"
			return @word = "Medical"
		when "hygiene", "clean", "cleaning", "shower"
			return @word = "Hygiene"
		when "technology", "computer", "tech"
			return @word = "Technology"
		when "legal", "law"
			return @word = "Legal"
		when "learning", "learn", "education", "teaching", "teach", "teacher"
			return @word = "Learning"
		when "suitability", "all", "facilities", "facility"
			return @word = "all"
		else
			return @word
		end
	end

	def keywordSearch(word)
		if word == "all"
			@facilities = Facility.all.where(:verified => true)
		else
		#
		# @facilities = Facility.where("services ~* ?", word).where(:verified => true)
		# if @facilities.exists?
			@facilities = Facility.where("suitability ~* ?", word).where(:verified => true)
		end
	end
end
