desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -I lib -r flash/cli.rb"
end
