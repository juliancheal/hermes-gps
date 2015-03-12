require 'celluloid/io'
require 'rubyserial'

module Hermes
  module GPS
    class Client
      include Celluloid::IO
      include Celluloid::Logger
      finalizer :disconnect

      def initialize
      end

      def self.connect(device, baud, &block)
        client.connect(&block)
        return client
      end

      def connect(device, baud)
      end

      def parse_nmea
      end
      
    end
  end
end
