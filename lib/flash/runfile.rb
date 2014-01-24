require 'flash'
require 'yaml'
require 'delegate'

class Flash::Runfile < SimpleDelegator

  def initialize(filename=nil)
    data = filename ? YAML.load_file(filename)  : {}
    super(data)
  end

end
