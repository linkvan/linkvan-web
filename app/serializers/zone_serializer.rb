class ZoneSerializer
    attr_accessor :zone

    def initialize(zone)
        @zone = zone
    end #/initialize

    def as_json(tmp=nil)
        {
            id: @zone.id,
            name: @zone.name,
            description: @zone.description,
            users: self.admins
        }
    end

    def admins
        @zone.users.select(:id, :name).as_json
    end

end #/ZoneSerializer