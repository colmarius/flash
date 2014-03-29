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

def flash(args)
  capture_stdout do
    begin
      Flash::CLI.start(args.split(" "))
    rescue SystemExit
    end
  end
end

def make_pipe
  IO.method(:pipe).arity.zero? ? IO.pipe : IO.pipe("BINARY")
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
