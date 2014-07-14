require 'flash'
require 'flash/command/base'
require 'pathname'

class Flash::Command::Run < Flash::Command::Base
  attr_reader :command

  attr_accessor :color
  attr_accessor :project
  attr_accessor :group

  def initialize(params)
    @params = params
    @command = params[1]
    @group = params[2]
  end

  def execute
    raise(ArgumentError, 'Missing required command and group parameters.') unless @command && @group

    projects.each do |project|
      change_color!
      self.project = project

      run "cd #{ project_dir }", false
      commands(command).each { |cmd| run(cmd) }

      say ''
    end
  end

  private

  def run(command, verbose = true)
    prompt command if verbose
    system "cd #{ project_dir } ; #{ command }"
  end

  def aliases
    config_file['aliases'] || {}
  end

  def projects
    config_file[group]
  end

  def commands(alias_or_command)
    commands = aliases[alias_or_command] || alias_or_command
    commands.split(';').map(&:strip)
  end

  def prompt(message)
    say "#{ project }> #{ message }"
  end

  def say(stuff)
    prefix = "\e[38;5;#{ color }m"
    suffix = "\e[0m"
    system "echo '#{ prefix }#{ stuff }#{ suffix }'"
  end

  def change_color!
    self.color = rand((1..22)) * 10 + 2
  end

  def project_dir
    "#{ Dir.pwd }/#{ project }"
  end
end
