require 'flash'
require 'yaml'

class Flash::Runfile

  def initialize(filename=nil)
    load(filename) if filename
    @groups = []
  end

  def [](name=nil)
    @groups[name] if name
  end

  def load(filename)
    @groups = YAML.load_file(filename) if File.exists?(filename)
  end
end
