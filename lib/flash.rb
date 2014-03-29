require 'flash/version'

module Flash
  def self.find_class(type)
    Flash.const_get(class_name(type))
  rescue NameError
    Flash::UnknownCommand
  end

  private

  def class_name(type)
    type.to_s.capitalize
  end
end
