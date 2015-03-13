module Hermes
  module GPS
    class NMEA

      attr_accessor :gga

      GGA = Struct.new(:type, :fix_taken_at, :latitude, :direction_latitude,
                        :longitude, :direction_longitude, :gps_quality,
                        :satellites_tracked, :horizontal_dilution_position,
                        :altitude, :altitude_unit, :geoid_height, :geoid_height_unit, :last_update_at,
                        :reference_station_id, :checksum)

      def initialize
      end

      def populate(opts = {})
        case opts[:type]
          when "GGA"
            gga = GGA.new(opts[:type],
                        opts[:fix_taken_at],
                        opts[:latitude],
                        opts[:direction_latitude],
                        opts[:longitude],
                        opts[:direction_longitude],
                        opts[:gps_quality],
                        opts[:satellites_tracked],
                        opts[:horizontal_dilution_position],
                        opts[:altitude],
                        opts[:altitude_unit],
                        opts[:geoid_height],
                        opts[:geoid_height_unit],
                        opts[:last_update_at],
                        opts[:reference_station_id])
        end
        [opts[:type], gga]
      end

    end
  end
end
