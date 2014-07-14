require 'flash'
require 'flash/command/base'

class Flash::Command::Info < Flash::Command::Base
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
      config_file[group].to_yaml
    else
      group ? "Unknown group \"#{group}\" in .flash.yml config." : config_file.to_yaml
    end
  end
end
