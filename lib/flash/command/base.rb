require 'flash/config'

module Flash
  module Command
    class Base
      def initialize
      end

      def config
        @config ||= Flash::Config.new
      end

      def valid_group?(group)
        config && config.key?(group)
      end
    end
  end
end
