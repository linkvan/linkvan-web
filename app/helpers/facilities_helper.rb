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

	#def display_distance(fac)

	#end
end
