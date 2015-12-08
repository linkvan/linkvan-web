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
   				content_arr += content_tag(:i, nil, class: "icon-sleepshelter_linkvan shelter-colour-index")
   			when "Food"
   				content_arr += content_tag(:i, nil, class: "glyphicon glyphicon-cutlery food-colour-index")
   			when "Medical"
   				content_arr += content_tag(:i, nil, class: "icon-Medical_linkvan medical-colour-index")
   			when "Hygiene"
   				content_arr += content_tag(:i, nil, class: "icon-hygiene_linkvan hygiene-colour-index")
   			when "Technology"
   				content_arr += content_tag(:i, nil, class: "icon-display technology-colour-index")
   			else
   				content_arr += content_tag(:i, nil, class: "icon-Advocacy_linkvan legal-colour-index")

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
				content_tag(:i, nil, class: "icon-id_linkvan food-colour")
			else
				content_tag(:i, nil, class: "icon-id_linkvan medical-colour")
			end
		when "pets"
			if t_or_f
				content_tag(:i, nil, class: "icon-pets_linkvan food-colour")
			else
				content_tag(:i, nil, class: "icon-pets_linkvan medical-colour")
			end
		when "cart"
			if t_or_f
				content_tag(:i, nil, class: "icon-shoppingcart_linkvan food-colour")
			else
				content_tag(:i, nil, class: "icon-shoppingcart_linkvan medical-colour")
			end
		when "phone"
			if t_or_f
				content_tag(:i, nil, class: "icon-phone_linkvan food-colour")
			else
				content_tag(:i, nil, class: "icon-phone_linkvan medical-colour")
			end
		else
			if t_or_f
				content_tag(:i, nil, class: "icon-connection food-colour")
			else
				content_tag(:i, nil, class: "icon-connection medical-colour")
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
end
