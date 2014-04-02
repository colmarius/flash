require 'flash'
require 'flash/command_matcher'

class Flash::CLI
  def initialize(params)
    @args = params
  end

  def start
    flash = setup
    flash.execute
  end

  def setup
    command_required if @args.empty?
    Flash::CommandMatcher.find_class(command).new(@args)
  end

  private

  def command
    @args[0].to_s.downcase
  end

  def command_required
    puts 'ERROR: Flash requires a command to run.'
    shutdown
  end

  def shutdown
    exit 1
  end
end
