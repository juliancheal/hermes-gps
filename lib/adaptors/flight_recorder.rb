require 'adaptors/adaptor'

module Hermes
  module Adaptors
    class FlightRecorder < Adaptor

      def initialize(params={})
        @sp = SerialPort.new(params[:port], 4800)
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
        nmea
      end

      def process(sp)
        while(data = sp.gets) do
          nmea = @nmea.parse_sentance(data)
          return nmea
        end
      end

    end
  end
end
