require 'flash'
require 'flash/command/clone'
require 'flash/command/info'
require 'flash/command/run'
require 'flash/command/unknown'

module Flash::CommandMatcher
  def self.find_class(type)
    Flash::Command.const_get(class_name(type))
  rescue NameError
    Flash::Command::Unknown
  end

  private

  def self.class_name(type)
    type.to_s.capitalize
  end
end
