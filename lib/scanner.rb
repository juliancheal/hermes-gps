require "celluloid/autostart"

module Hermes
  module GPS
    class Scanner
      include Celluloid, Celluloid::Notifications

      def initialize
        @connection = Connection.new({name: :flight_recorder, adaptor: :flight_recorder, port: "/dev/tty.SLAB_USBtoUART"})
      end

      def scan(interval)
        every interval do
          nmea = @connection.read_and_process
          case nmea[0]
            when "GGA"
              publish("GGA", nmea[1])
          end
        end
      end

    end
  end
end
