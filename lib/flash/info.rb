require 'flash'
require 'flash/runfile'

class Flash::Info < Flash::Base
  attr_reader :group

  def initialize(params)
    @params = params
    @group = params[1]
  end

  def start
    puts output
  end

  private

  def output
    if valid_runfile_group?
      runfile[group].to_yaml
    else
      group ? "Unknown group \"#{group}\" in Runfile." : runfile.to_yaml
    end
  end

  def valid_runfile_group?
    group && runfile[group]
  end
end
