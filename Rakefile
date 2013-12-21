require "rspec/core/rake_task"

RSpec::Core::RakeTask.new do |task|
  task.name = 'spec'
  task.rspec_opts = ['-c',' -f', 'd']
end

task :build do
  system "gem build flash.gemspec"
end

task :release => :build do
  system "gem push flash-#{Flash::VERSION}"
end

task :default => :spec
