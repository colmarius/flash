$:.unshift File.expand_path("../lib", __FILE__)

require 'flash'

require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop'
require 'rubocop/rake_task'

task :default => [:spec, :rubocop]

desc 'Run all specs'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

desc 'Run RuboCop on the lib directory'
Rubocop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['exe/flash', 'lib/**/*.rb', 'spec/**/*.rb']
  # don't abort rake on failure
  task.fail_on_error = false
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -I lib -r flash/cli.rb"
end
