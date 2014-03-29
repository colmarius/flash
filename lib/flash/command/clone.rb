require 'flash'
require 'flash/command/base'

class Flash::Command::Clone < Flash::Command::Base
  attr_reader :group

  def initialize(params)
    @params = params
    @group = params[1]
  end

  def execute
    raise(ArgumentError, 'Missing required group parameter.') unless @group

    unknown_group_and_exit unless valid_group?(group)
    clone_projects
  end

  private

  def unknown_group_and_exit
    puts "Unknown group \"#{group}\" in Runfile."
    exit 1
  end

  def clone_projects
    projects.each do |project|
      clone_single(project) unless File.exist?(project)
    end
  end

  def projects
    runfile[group] || []
  end

  def clone_single(project)
    system('git', 'clone', clone_path(project))
    puts "\n[#{project}] Done cloning project.\n\n"
  end

  def clone_path(project)
    "#{ base_clone_path }/#{ project }.git"
  end

  def base_clone_path
    base_url = runfile['clone']['git']
    base_url.gsub(/\/+$/, '')
  end
end