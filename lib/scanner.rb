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
          publish(nmea[0], nmea[1]) unless nmea[0].nil?
        end
      end

    end
  end
end
