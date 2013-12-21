require 'flash'
require 'flash/runfile'

class Flash::Runner
  attr_reader :options
  attr_accessor :debug, :color, :dir_name, :group

  def initialize(options = {}, group)
    @options = options
    @group = Flash::Runfile.new('Runfile')[group]
  end

  def pwd
    Dir.pwd
  end

  def run(command, verbose=true)
    say "#{ prompt }#{ command }" if verbose
    system "cd #{ app_dir } && #{ command }"
    say "[Debug] Result: #{ $?.inspect }" if verbose && debug
  end

  def recipes
    @recipes ||= {
      'update-master' => 'git stash ; git checkout master ; git pull ; git stash pop',
      'status' => 'git status -s',
      'branch' => 'git branch'
    }
  end

  def list_recipes
    recipes.each_pair { |recipe, commands| puts %Q(#{ recipe }:\n\t"#{ commands }"\n\n) }
  end

  def commands(recipe)
    commands = recipes[recipe] ? recipes[recipe] : 'echo "Unknown recipe!"'
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

  def start
    list_recipes and exit if options[:list_recipes]

    self.debug = options[:debug]
    group.each do |dir_name|
      change_color!
      self.dir_name = dir_name
      run "cd #{ pwd }/#{ dir_name }", false

      commands = options[:recipe] ? commands(options[:recipe]) : options[:commands]
      commands.each { |command| run(command) }\

      say ""
    end
  end
end
