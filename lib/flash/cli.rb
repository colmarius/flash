require 'flash'
require 'flash/runner'
require 'pathname'

class Flash::CLI

  def self.start
    if ARGV.empty? || ARGV.length != 2
      puts "ERROR: Command and Group are missing."
      exit 1
    end

    command = ARGV[0]
    group = ARGV[1]
    Flash::Runner.new(command, group).start
  end

end
