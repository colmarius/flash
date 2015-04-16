require 'flash/command/base'

module Flash
  module Command
    class Info < Base
      def initialize(group = nil)
        @group = group
      end

      def execute
        puts output(@group)
      end

      private

      def output(group = nil)
        return unknown_group(group) if group && !valid_group?(group)

        result = valid_group?(group) ? config[group] : config
        result.to_yaml
      end

      def unknown_group(group)
        "Unknown group \"#{group}\" in .flash.yml config."
      end
    end
  end
end
