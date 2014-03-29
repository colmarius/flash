require 'flash'
require 'flash/clone'
require 'flash/run'
require 'flash/info'
require 'flash/unknown_command'
require 'pathname'

class Flash::CLI
  def initialize(params)
    @args = params
  end

  def start
    command_required if @args.empty?
    Flash.find_class(command).new(@args).start
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
