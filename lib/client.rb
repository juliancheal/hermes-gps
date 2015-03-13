# require 'celluloid/io'
require 'rubyserial'

module Hermes
  module GPS
    class Client
      # include Celluloid::IO
      # finalizer :shutdown

      def initialize(device, baud=4800)
        @sp = Serial.new(device, baud)
        @nmea = Hermes::GPS::NMEA.new
        @buffer = ""
      end

      def read_and_process
        loop do
          process(read)
        end
      end

      def read
        return @sp.read(1024)
      end

      def process(data)
        bytes = StringIO.new(String(data))
        while byte = bytes.gets
          if byte[0] == "$"
            nmea = @nmea.parse_sentance(@buffer)
            @buffer = ""
            return nmea
          else
            @buffer << byte
          end
        end
      end

    end
  end
end
