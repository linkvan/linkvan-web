class Facility < ActiveRecord::Base

	def self.contains_service?(service_query)
		arr = Array.new
		facility = Facility.select("services", "id")

		facility.each do |f|
			if f.services.include?(service_query)
				arr.push(Facility.find(f.id))
			end
		end

		arr
	end

end
