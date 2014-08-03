require 'flash'
require 'flash/command/base'

class Flash::Command::Clone < Flash::Command::Base
  def initialize(group)
    @group = group
  end

  def execute
    raise(ArgumentError, 'Missing required group parameter.') unless @group

    unknown_group_and_exit(@group) unless valid_group?(@group)
    clone_projects(@group)
  end

  private

  def unknown_group_and_exit(group)
    puts "Unknown group \"#{group}\" in .flash.yml config."
    exit 1
  end

  def clone_projects(group)
    projects(group).each do |project|
      clone_single(project) unless File.exist?(project)
    end
  end

  def projects(group)
    config[group] || []
  end

  def clone_single(project)
    system('git', 'clone', clone_path(project))
    puts "\n[#{project}] Done cloning project.\n\n"
  end

  def clone_path(project)
    "#{ base_clone_path }/#{ project }.git"
  end

  def base_clone_path
    base_url = config['clone']['git']
    base_url.gsub(/\/+$/, '')
  end
end
