$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'fakefs/safe'
require 'fakefs/spec_helpers'

Dir[File.expand_path('../support/*.rb', __FILE__)].each { |file| require file }

RSpec.configure do |config|
  config.include(FakeFS::SpecHelpers, :fakefs)
  config.include(HelperMethods)

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!
  config.raise_errors_for_deprecations!

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.color = true
  config.full_backtrace = false
  config.order = :random
end
