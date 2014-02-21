require 'flash'
require 'yaml'
require 'delegate'

class Flash::Runfile < SimpleDelegator

  def initialize(filename=nil)
    unless File.exists?(filename)
      puts "ERROR: missing Runfile"
      exit 1
    end

    data = filename ? YAML.load_file(filename)  : {}
    super(data)
  end

end
