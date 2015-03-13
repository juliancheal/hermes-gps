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
          data = @connection.read_and_process
          unless data.empty?
            case data[:last_nmea]
              when "GGA"
                publish("GGA", data)
            end
          end
        end
      end

    end
  end
end
