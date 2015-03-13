require 'serialport'

module Hermes
  module GPS
    class SerialIO

      def initialize(device, baud=4800)
        @sp = SerialPort.new(device, baud)
        @nmea = Hermes::GPS::NMEA.new
        @buffer = ""
      end

      def read_and_process
        # nmea = process(read)
        nmea = process(@sp)
        # puts nmea
        nmea
      end

      def read
        return @sp#.read(1)
      end

      def process(sp)
        while(data = sp.gets) do
          nmea = @nmea.parse_sentance(data)
          return nmea
          # if data == "$"
          #   nmea = @nmea.parse_sentance(@buffer)
          #   puts nmea
          #   @buffer = ""
          #   return nmea
          # else
          #   @buffer << data
          # end
        end
      end

    end
  end
end
