# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "flash/version"

Gem::Specification.new do |gem|
  gem.name    = "flash"
  gem.license = "Apache-2.0"
  gem.version = Flash::VERSION

  gem.author   = ["Marius Colacioiu"]
  gem.email    = ["marius.colacioiu@gmail.com"]
  gem.homepage = "http://github.com/colmarius/flash"
  gem.summary  = %q{ Flash helps you run same commands on multiple projects all defined in the `.flash.yml` config. }

  gem.description = gem.summary

  gem.bindir      = 'exe'
  gem.executables = `git ls-files -- exe/*`.split("\n").map{ |f| File.basename(f) }
  gem.files = Dir["**/*"].select { |d| d =~ %r{^(README|exe/|lib/|spec/)} }

  gem.add_dependency 'thor', '~> 0.19.1'
end
