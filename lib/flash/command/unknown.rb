require 'flash'
require 'flash/command'

class Flash::Command::Unknown
  def initialize(args)
    @command = args[0]
  end

  def execute
    puts "ERROR: Flash does not know command: #{@command}."
    shutdown
  end

  private

  def shutdown
    exit 1
  end
end
