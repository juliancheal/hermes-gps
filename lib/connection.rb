require "celluloid"

module Hermes
  module GPS
    class Connection
      include Celluloid

      attr_reader :parent, :name, :port, :adaptor, :connection_id, :details

      def initialize(params={})
        @name = params[:name].to_s
        @port = params[:port]

        require_adaptor(params[:adaptor] || :loopback, params)
      end

      def connect
        Logger.info "Connecting to '#{name}' on port '#{port}'..."
        adaptor.connect
      rescue Exception => e
        Logger.error e.message
        Logger.error e.backtrace.inspect
      end

      def disconnect
        Logger.info "Disconnecting from '#{name}' on port '#{port}'..."
        adaptor.disconnect
      end

      def connected?
        adaptor.connected?
      end

      def adaptor_name
        adaptor.class.name
      end

      # Redirects missing methods to adaptor,
      # attemps reconnection if adaptor not connected
      def method_missing(method_name, *arguments, &block)
        unless adaptor.connected?
          Logger.warn "Cannot call unconnected adaptor '#{name}', attempting to reconnect..."
          adaptor.reconnect
          return nil
        end
        adaptor.send(method_name, *arguments, &block)
      rescue Exception => e
        Logger.error e.message
        Logger.error e.backtrace.inspect
        return nil
      end

      def respond_to_missing?(method_name, include_private = false)
        # TODO: verify that the adaptor supprts the method we're calling
        true
      end

      private

      def require_adaptor(type, params)
        require "adaptors/#{type.to_s}"
        @adaptor = constantize("Hermes::Adaptors::#{classify(type.to_s)}").new(port: port)
      end

      def classify(word)
        underscore(word).gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      end

      def underscore(camel_cased_word)
        word = camel_cased_word.to_s.dup
        word.gsub!(/::/, '/')
        word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
        word.tr!("-", "_")
        word.downcase!
        word
      end

      def constantize(camel_cased_word)
        names = camel_cased_word.split('::')
        names.shift if names.empty? || names.first.empty?

        names.inject(Object) do |constant, name|
          if constant == Object
            constant.const_get(name)
          else
            candidate = constant.const_get(name)
            next candidate if constant.const_defined?(name, false)
            next candidate unless Object.const_defined?(name)

            # Go down the ancestors to check it it's owned
            # directly before we reach Object or the end of ancestors.
            constant = constant.ancestors.inject do |const, ancestor|
              break const    if ancestor == Object
              break ancestor if ancestor.const_defined?(name, false)
              const
            end

            # owner is in Object, so raise
            constant.const_get(name, false)
          end
        end
      end

    end
  end
end
