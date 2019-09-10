class FacilitiesSerializer
    attr_accessor :facilities

    def initialize(facilities)
        @facilities = facilities
    end #/initialize

    def as_json(tmp=nil)
        @facilities.map do |facility|
            FacilitySerializer.new(facility).as_json(tmp)
        end
    end

end #/FacilitiesSerializer