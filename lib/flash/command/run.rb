require 'flash'
require 'flash/command/base'
require 'pathname'

class Flash::Command::Run < Flash::Command::Base
  attr_accessor :project

  def initialize(command, group)
    @command = command
    @group = group
  end

  def execute
    raise(ArgumentError, 'Missing required command and group parameters.') unless @command && @group

    unknown_group_and_exit(@group) unless valid_group?(@group)
    run_command_in_group(@command, @group)
  end

  private

  def unknown_group_and_exit(group)
    puts "Unknown group \"#{group}\" in .flash.yml config."
    exit 1
  end

  def run_command_in_group(command, group)
    projects(group).each do |project|
      color = new_color
      self.project = project

      run("cd #{ project_dir }", verbose: false, color: color)
      commands(command).each { |cmd| run(cmd, color: color) }

      say '', color
    end
  end

  def projects(group)
    config[group]
  end

  def run(command, options = {})
    verbose = options[:verbose] || true
    color   = options[:color]

    prompt(command, color) if verbose
    system "cd #{ project_dir } ; #{ command }"
  end

  def commands(alias_or_command)
    commands = aliases[alias_or_command] || alias_or_command
    commands.split(';').map(&:strip)
  end

  def aliases
    config['aliases'] || {}
  end

  def prompt(message, color)
    say "#{ project }> #{ message }", color
  end

  def say(stuff, color)
    prefix = "\e[38;5;#{ color }m"
    suffix = "\e[0m"
    system "echo '#{ prefix }#{ stuff }#{ suffix }'"
  end

  def new_color
    rand((1..22)) * 10 + 2
  end

  def project_dir
    "#{ Dir.pwd }/#{ project }"
  end
end
