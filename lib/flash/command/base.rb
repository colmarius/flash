require 'flash'
require 'flash/command'
require 'flash/config'

class Flash::Command::Base
  def initialize
  end

  def config_file
    @config_file ||= Flash::Config.new
  end

  def valid_group?(group)
    group && config_file[group]
  end
end
