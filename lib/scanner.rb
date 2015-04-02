require "celluloid/autostart"

module Hermes
  module GPS
    class Scanner
      include Celluloid, Celluloid::Notifications

      def initialize(params)
        puts caller[0]
        @connection = Connection.new(params[0].to_h)
      end

      def scan(interval)
        every interval do
          nmea = @connection.read_and_process
          publish(nmea[0], nmea[1]) unless nmea[0].nil?
        end
      end

    end
  end
end
