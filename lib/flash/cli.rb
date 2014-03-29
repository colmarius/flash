require 'flash'
require 'flash/run'
require 'pathname'

class Flash::CLI

  def self.start(params)
    if params.empty?
      puts "ERROR: Flash requires a command to run."
      exit 1
    end

    command = params[0].to_s.downcase

    case command
    when 'run'
      Flash::Run.new(params).start
    else
      puts "ERROR: Flash does not known command: #{command}."
    end
  end
end
