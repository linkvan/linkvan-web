class FacilitySerializer
    attr_accessor :facility

    def initialize(facility)
        @facility = facility
    end #/initialize

    def as_json(tmp=nil)
        {
            id: @facility.id,
            name: @facility.name,
            welcomes: self.welcomes,
            services: self.services,
            address: @facility.address,
            phone: @facility.phone,
            lat: @facility.lat,
            long: @facility.long,
            verified: @facility.verified,
            website: @facility.website,
            notes: @facility.notes,
            r_pets: @facility.r_pets,
            r_id: @facility.r_id,
            r_cart: @facility.r_cart,
            r_phone: @facility.r_phone,
            r_wifi: @facility.r_wifi,
            shelter_note: @facility.shelter_note,
            food_note: @facility.food_note,
            medical_note: @facility.medical_note,
            hygiene_note: @facility.hygiene_note,
            technology_note: @facility.technology_note,
            legal_note: @facility.legal_note,
            learning_note: @facility.learning_note,
            startsmon_at: @facility.startsmon_at,
            endsmon_at: @facility.endsmon_at,
            startstues_at: @facility.startstues_at,
            endstues_at: @facility.endstues_at,
            startswed_at: @facility.startswed_at,
            endswed_at: @facility.endswed_at,
            startsthurs_at: @facility.startsthurs_at,
            endsthurs_at: @facility.endsthurs_at,
            startsfri_at: @facility.startsfri_at,
            endsfri_at: @facility.endsfri_at,
            startssat_at: @facility.startssat_at,
            endssat_at: @facility.endssat_at,
            startssun_at: @facility.startssun_at,
            endssun_at: @facility.endssun_at,
            startsmon_at2: @facility.startsmon_at2,
            endsmon_at2: @facility.endsmon_at2,
            startstues_at2: @facility.startstues_at2,
            endstues_at2: @facility.endstues_at2,
            startswed_at2: @facility.startswed_at2,
            endswed_at2: @facility.endswed_at2,
            startsthurs_at2: @facility.startsthurs_at2,
            endsthurs_at2: @facility.endsthurs_at2,
            startsfri_at2: @facility.startsfri_at2,
            endsfri_at2: @facility.endsfri_at2,
            startssat_at2: @facility.startssat_at2,
            endssat_at2: @facility.endssat_at2,
            startssun_at2: @facility.startssun_at2,
            endssun_at2: @facility.endssun_at2,
            open_all_day_mon: @facility.open_all_day_mon,
            open_all_day_tues: @facility.open_all_day_tues,
            open_all_day_wed: @facility.open_all_day_wed,
            open_all_day_thurs: @facility.open_all_day_thurs,
            open_all_day_fri: @facility.open_all_day_fri,
            open_all_day_sat: @facility.open_all_day_sat,
            open_all_day_sun: @facility.open_all_day_sun,
            closed_all_day_mon: @facility.closed_all_day_mon,
            closed_all_day_tues: @facility.closed_all_day_tues,
            closed_all_day_wed: @facility.closed_all_day_wed,
            closed_all_day_thurs: @facility.closed_all_day_thurs,
            closed_all_day_fri: @facility.closed_all_day_fri,
            closed_all_day_sat: @facility.closed_all_day_sat,
            closed_all_day_sun: @facility.closed_all_day_sun,
            second_time_mon: @facility.second_time_mon,
            second_time_tues: @facility.second_time_tues,
            second_time_wed: @facility.second_time_wed,
            second_time_thurs: @facility.second_time_thurs,
            second_time_fri: @facility.second_time_fri,
            second_time_sat: @facility.second_time_sat,
            second_time_sun: @facility.second_time_sun,
            zone: self.zone
        }
    end

    def zone
        return [] if @facility.zone.nil?
        z = @facility.zone
        { id: z.id, name: z.name }
    end

    def welcomes
        return [] if @facility.welcomes.nil?
        @facility.welcomes.split(' ')
    end #/welcomes
    
    def services
        return [] if @facility.services.nil?
        @facility.services.split(' ')
    end #/services


end #/FacilitySerializer