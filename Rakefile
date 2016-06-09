$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'flash'

require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task default: [:spec, :rubocop]

desc 'Run all specs'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

desc 'Run RSpec with code coverage'
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task['spec'].execute
end

desc 'Run RuboCop on this library'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['exe/flash', 'lib/**/*.rb', 'spec/**/*.rb']
  task.fail_on_error = false
end
