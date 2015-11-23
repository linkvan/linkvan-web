module FacilitiesHelper

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
   				content_arr += content_tag(:i, nil, class: "icon-Advocacy_linkvan medical-colour-index")

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

	#def display_distance(fac)

	#end
end
