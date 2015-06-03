module FacilitiesHelper

	def display_services(services_str)
		content_arr = ""
		services_arr = services_str.split(" ")
		services_arr.each do |s|
			case s
			when "Shelter"
   				content_arr += content_tag(:i, nil, class: "glyphicon glyphicon-home shelter-colour-index")
   			when "Food"
   				content_arr += content_tag(:i, nil, class: "glyphicon glyphicon-cutlery food-colour-index")
   			when "Medical"
   				content_arr += content_tag(:i, nil, class: "glyphicon glyphicon-heart-empty medical-colour-index")
   			when "Hygiene"
   				content_arr += content_tag(:i, nil, class: "glyphicon glyphicon-tint hygiene-colour-index")
   			when "Technology"
   				content_arr += content_tag(:i, nil, class: "glyphicon glyphicon-globe technology-colour-index")
   			else
   				content_arr += content_tag(:i, nil, class: "glyphicon glyphicon-briefcase legal-colour-index")

			end #ends case
		end

		return content_arr.html_safe
	end

	#def display_distance(fac)

	#end
end
