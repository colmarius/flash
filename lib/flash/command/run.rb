require 'flash/command/base'
require 'pathname'

module Flash
  module Command
    class Run < Base
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

          system('cd', project_dir(project))
          commands(command).each { |cmd| run(cmd, color: color, project: project) }

          say('', color)
        end
      end

      def projects(group)
        config[group]
      end

      def run(command, options = {})
        verbose = options[:verbose].nil? ? true : options[:verbose]
        color   = options[:color]
        project = options[:project]

        prompt(command, color: color, project: project) if verbose
        system("cd #{project_dir(project)} ; #{command}")
      end

      def commands(alias_or_command)
        commands = aliases[alias_or_command] || alias_or_command
        commands.split(';').map(&:strip)
      end

      def aliases
        config['aliases'] || {}
      end

      def prompt(message, options)
        color   = options[:color]
        project = options[:project]

        say("#{project}> #{message}", color)
      end

      def say(stuff, color)
        prefix = "\e[38;5;#{color}m"
        suffix = "\e[0m"
        system "echo '#{prefix}#{stuff}#{suffix}'"
      end

      def new_color
        rand((1..22)) * 10 + 2
      end

      def project_dir(project)
        "#{Dir.pwd}/#{project}"
      end
    end
  end
end
