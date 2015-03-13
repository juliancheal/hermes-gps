require "celluloid/autostart"

module Hermes
  module GPS
    class Scanner
      include Celluloid, Celluloid::Notifications

      def initialize
        @serial = Hermes::GPS::SerialIO.new("/dev/tty.SLAB_USBtoUART", 4800)
      end

      def scan(interval)
        every interval do
          data = @serial.read_and_process
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
