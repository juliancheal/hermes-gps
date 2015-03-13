# require 'celluloid/io'

module Hermes
  module GPS
    class Scanner
      # include Celluloid::IO
      # include Celluloid::Logger
      # finalizer :disconnect

      def initialize(*args)
        @client = Hermes::GPS::Client.new("/dev/tty.SLAB_USBtoUART", 4800)
      end

      def self.connect(*args, &block)
        client = Hermes::GPS::Scanner.new(*args)
        client.connect(&block)
        return client
      end

      def subscribe(geos)
        @client.read_and_process
        # @client.async.read
      end

    end
  end
end
