require 'flash'
require 'flash/base'

class Flash::Clone < Flash::Base
  attr_reader :group

  def initialize(params)
    @params = params
    @group = params[1]

    raise(ArgumentError, 'Missing required group parameter.') unless @group
  end

  def start
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
    cloned_repo_path = clone_path(project)
    system('git', 'clone', cloned_repo_path)
    puts "\n[#{project}] Done cloning project.\n\n"
  end

  def clone_path(project)
    "#{base_clone_path}/#{project}"
  end

  def base_clone_path
    runfile['clone']['github']
  end
end
