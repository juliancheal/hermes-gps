require 'serialport'

module Hermes
  module GPS
    class SerialIO

      def initialize(device, baud=4800)
        @sp = SerialPort.new(device, baud)
        @nmea_parser = Hermes::GPS::NMEAParser.new
        @nmea = Hermes::GPS::NMEA.new
      end

      def read_and_process
        nmea = process(@sp)
        nmea
      end

      def process(sp)
        while(data = sp.gets) do
          parsed_data = @nmea_parser.parse_sentance(data)
          return @nmea.populate(parsed_data)
        end
      end

    end
  end
end
