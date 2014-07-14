$:.unshift File.expand_path("../lib", __FILE__)
require 'flash'

require 'bundler/setup'
require 'bundler/gem_tasks'

Dir[File.expand_path('../tasks/*.rake', __FILE__)].each do |task|
  load task
end
