class ZonesSerializer
    attr_accessor :zones

    def initialize(zones)
        @zones = zones
    end #/initialize

    def as_json(tmp=nil)
        @zones.map do |zone|
            ZoneSerializer.new(zone).as_json(tmp)
        end
    end

end #/ZoneSerializer