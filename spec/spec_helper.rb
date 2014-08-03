if ENV['TRAVIS'] || ENV['COVERAGE']
  require 'simplecov'

  if ENV['TRAVIS']
    require 'coveralls'
    SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  end

  SimpleCov.start do
    add_filter '/spec'
    add_filter '/vendor'
  end
end

require 'rspec'
require 'fakefs/safe'
require 'fakefs/spec_helpers'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

RSpec.configure do |config|
  config.color = true
  config.order = 'rand'
  config.raise_errors_for_deprecations!
  config.include FakeFS::SpecHelpers, :fakefs
end

def flash(args)
  capture_stdout do
    begin
      Flash::CLI.start(args.split(' '))
    rescue SystemExit
      nil
    end
  end
end

def write_config_file(options = {})
  config_file = options[:config_file] || '.flash.yml'
  contents    = options[:contents] || default_contents

  File.open(config_file, 'w') do |file|
    contents.split('\n').each do |line|
      file.puts line
    end
  end
  File.expand_path(config_file)
end

def default_contents
  <<-CONTENTS
    projects:
      - foo
      - bar
      - buz
    libraries:
      - cippa
      - lippa
  CONTENTS
end

def make_pipe
  IO.method(:pipe).arity.zero? ? IO.pipe : IO.pipe('BINARY')
end

def capture_stdout
  old_stdout = $stdout.dup
  rd, wr = make_pipe
  $stdout = wr
  yield
  wr.close
  rd.read
ensure
  $stdout = old_stdout
end
