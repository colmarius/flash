require 'flash'
require 'yaml'
require 'delegate'

class Flash::Config < SimpleDelegator
  def initialize(filename = nil)
    unless File.exist?(filename)
      puts 'ERROR: missing .flash.yml config.'
      exit 1
    end

    data = filename ? YAML.load_file(filename)  : {}
    super(data)
  end
end
