require 'flash'
require 'yaml'

class Flash::Runfile

  def initialize(filename=nil)
    load(filename) if filename
    @groups = []
  end

  def [](name)
    @groups[name]
  end

  def load(filename)
    @groups = YAML.load_file(filename)
  end
end
