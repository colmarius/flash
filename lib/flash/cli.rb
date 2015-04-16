require 'flash/command/clone'
require 'flash/command/info'
require 'flash/command/run'
require 'flash/version'
require 'thor'

module Flash
  class CLI < Thor
    class << self
      def is_thor_reserved_word?(word, type)
        return false if word == 'run'
        super
      end
    end

    desc 'clone GROUP', 'Clone all projects found in GROUP config file'

    def clone(group)
      Flash::Command::Clone.new(group).execute
    end

    desc 'info [GROUP]', 'Display information from config file'

    def info(group = nil)
      Flash::Command::Info.new(group).execute
    end

    desc 'run COMMAND GROUP', 'Run one or more COMMAND(s) on the specified GROUP'

    long_desc <<-LONGDESC
      Run the COMMAND(s) on the specified GROUP.

      More than one command can be specified if wrapped under quotes
      and are semi-column separated.

      In alternative aliases can be used, which can be defined under "aliases"
      in .flash.yml config file.
    LONGDESC

    def run(command, group)
      Flash::Command::Run.new(command, group).execute
    end

    desc 'version', 'Display Flash gem version'

    map ['-v', '--version'] => :version

    def version
      puts Flash::VERSION
    end
  end
end
