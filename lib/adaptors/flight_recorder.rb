require 'adaptors/adaptor'

module Hermes
  module Adaptors
    class FlightRecorder < Adaptor

      def initialize(params={})
        @sp = Hermes::GPS::SerialIO.new(params[:port], params[:baud])
        @nmea_parser = Hermes::GPS::NMEAParser.new
      end

      def connect
      end

      def disconnect
      end

      def connected?
        true
      end

      def read_and_process
        @sp.read_and_process
      end

      # def process(data)
      #   while(@sentence = @sp.gets) do
      #     @nmea_parser.parse_sentance(@sentence)
      #   end
      # end

    end
  end
end
