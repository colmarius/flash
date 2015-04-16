$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'fakefs/safe'
require 'fakefs/spec_helpers'

Dir[File.expand_path('../support/*.rb', __FILE__)].each { |file| require file }

RSpec.configure do |config|
  config.color = true
  config.order = 'rand'
  config.raise_errors_for_deprecations!
  config.include(FakeFS::SpecHelpers, :fakefs)
  config.include(HelperMethods)
end
