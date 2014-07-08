require 'flash'
require 'flash/command'
require 'flash/runfile'

class Flash::Command::Base
  def initialize
  end

  def runfile
    @runfile ||= Flash::Runfile.new('Runfile')
  end

  def valid_group?(group)
    group && runfile[group]
  end
end
