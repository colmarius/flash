require 'flash'
require 'flash/base'

class Flash::Info < Flash::Base
  attr_reader :group

  def initialize(params)
    @params = params
    @group = params[1]
  end

  def execute
    puts output
  end

  private

  def output
    if valid_group?(group)
      runfile[group].to_yaml
    else
      group ? "Unknown group \"#{group}\" in Runfile." : runfile.to_yaml
    end
  end
end
