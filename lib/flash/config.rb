require 'flash'
require 'yaml'
require 'delegate'

class Flash::Config < SimpleDelegator
  def initialize
    check_config_file!
    data = YAML.load_file(config_file)
    super(data)
  end

  private

  def check_config_file!
    error("#{config_file} does not exist.") unless File.exist?(config_file)
  end

  def config_file
    '.flash.yml'
  end

  def error(message)
    puts "ERROR: #{message}"
    exit 1
  end
end
