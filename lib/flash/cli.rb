require 'flash'
require 'flash/run'
require 'pathname'

class Flash::CLI

  def self.start
    if ARGV.empty?
      puts "ERROR: Flash requires a command to run."
      exit 1
    end

    command = ARGV[0].to_s.downcase

    case command
    when 'run'
      Flash::Run.new(ARGV).start
    else
      puts "ERROR: Flash does not known command: #{command}."
    end
  end

end
