require 'flash'
require 'flash/command'
require 'flash/config'

class Flash::Command::Base
  def initialize
  end

  def config
    @config ||= Flash::Config.new
  end

  def valid_group?(group)
    group && config[group]
  end
end
