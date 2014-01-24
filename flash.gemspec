# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "flash/version"

Gem::Specification.new do |gem|
  gem.name    = "flash"
  gem.license = "MIT"
  gem.version = Flash::VERSION

  gem.author   = ["Marius Colacioiu"]
  gem.email    = ["marius.colacioiu@gmail.com"]
  gem.homepage = "http://github.com/colmarius/flash"
  gem.summary  = %q{ Flash helps you run same commands on multiple projects all defined in the Runfile. }

  gem.description = gem.summary

  gem.rubyforge_project = "flash"

  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {spec}`.split("\n")
end
