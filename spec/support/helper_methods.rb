module HelperMethods
  def flash(args)
    capture_stdout do
      begin
        Flash::CLI.start(args.split(' '))
      rescue SystemExit
        nil
      end
    end
  end

  def write_config_file_with_clone
    clone_contents = <<-SECTION
      clone:
        git: git@github.com:SuperDuper
    SECTION

    write_config_file(contents: default_contents + clone_contents)
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
end
