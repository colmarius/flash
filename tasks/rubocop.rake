require 'rubocop/rake_task'

desc 'Run RuboCop on the lib directory'
Rubocop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['exe/flash', 'lib/**/*.rb', 'spec/**/*.rb']
  # don't abort rake on failure
  task.fail_on_error = false
end
