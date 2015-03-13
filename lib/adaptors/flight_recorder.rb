require 'adaptors/adaptor'

module Hermes
  module Adaptors
    class FlightRecorder < Adaptor

      def initialize(params={})
        @sp = SerialPort.new(params[:port], 4800)
        @nmea_parser = Hermes::GPS::NMEAParser.new
        @nmea = Hermes::GPS::NMEA.new
        @buffer = ""
      end

      def connect
      end

      def disconnect
      end

      def connected?
        true
      end

      def read_and_process
        nmea = process(@sp)
        return nmea
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
