require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'rspec'

$:.unshift File.expand_path('../../lib', __FILE__)

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.color_enabled = true
  config.order = 'rand'
end