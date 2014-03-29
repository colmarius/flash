require 'flash'
require 'flash/base'

class Flash::Run < Flash::Base
  attr_reader :command

  attr_accessor :color
  attr_accessor :dir_name
  attr_accessor :group

  def initialize(params)
    @params = params
    @command = params[1]
    @group = params[2]

    raise(ArgumentError, 'Missing required command and group parameters.') unless @command && @group
  end

  def pwd
    Dir.pwd
  end

  def run(command, verbose = true)
    say "#{ prompt }#{ command }" if verbose
    Dir.exist? "#{ app_dir }"
    system "cd #{ app_dir } ; #{ command }"
  end

  def aliases
    runfile['aliases'] || {}
  end

  def commands(alias_or_command)
    commands = aliases[alias_or_command] || alias_or_command
    commands.split(';').map(&:strip)
  end

  def say(stuff)
    prefix = "\e[38;5;#{ color }m"
    suffix = "\e[0m"
    system "echo '#{ prefix }#{ stuff }#{ suffix }'"
  end

  def change_color!
    self.color = rand((1..22)) * 10 + 2
  end

  def app_dir
    "#{ pwd }/#{ dir_name }"
  end

  def prompt
    "#{ dir_name }> "
  end

  def group_dirs
    runfile[group]
  end

  def start
    group_dirs.each do |dir_name|
      change_color!
      self.dir_name = dir_name
      run "cd #{ pwd }/#{ dir_name }", false

      commands(command).each { |command| run(command) }

      say ''
    end
  end
end
