require 'flash'
require 'flash/command/base'

class Flash::Command::Info < Flash::Command::Base
  attr_reader :group

  def initialize(group)
    @group = group
  end

  def execute
    puts output
  end

  private

  def output
    if valid_group?(group)
      config[group].to_yaml
    else
      group ? "Unknown group \"#{group}\" in .flash.yml config." : config.to_yaml
    end
  end
end
