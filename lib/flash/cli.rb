require 'flash'
require 'flash/runner'
require 'optparse'
require 'pathname'

class Flash::CLI

  def self.start
    options = {}
    optparse = OptionParser.new do |opts|
      opts.banner = "Usage: run [options] group"

      opts.on("-c", "--command command", String, "Commands to run (semicolon separated)") do |command|
        options[:command] = command
      end

      opts.on("-h", "--help", "Help documentation") do
        puts opts ; exit
      end

      opts
    end
    optparse.parse!

    if ARGV.empty?
      puts "Group name is missing."
      puts optparse ; exit
    end

    group = ARGV[0]
    Flash::Runner.new(options, group).start
  end

end
