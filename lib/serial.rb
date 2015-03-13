require 'rubyserial'

module Hermes
  module GPS
    class Serial

      def initialize(device, baud=4800)
        @sp = Serial.new(device, baud)
        @nmea = Hermes::GPS::NMEA.new
        @buffer = ""
      end

      def read_and_process
        # nmea = process(read)
        # nmea
        "ALL THE LOCATIONS"
      end

      def read
        return @sp.read(1024)
      end

      def process(data)
        bytes = StringIO.new(String(data))
        while byte = bytes.gets
          if byte[0] == "$"
            nmea = @nmea.parse_sentance(@buffer)
            @buffer = ""
            return nmea
          else
            @buffer << byte
          end
        end
      end

    end
  end
end
