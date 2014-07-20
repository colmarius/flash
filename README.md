[![Build Status](https://travis-ci.org/colmarius/flash.svg?branch=master)](https://travis-ci.org/colmarius/flash?branch=master)
[![Coverage Status](https://img.shields.io/coveralls/colmarius/flash.svg?branch=master)](https://coveralls.io/r/colmarius/flash?branch=master)

Flash helps you run arbitrary commands on multiple projects. Both _projects_ and _commands_ are defined in the .flash.yml.

## Installation

You can either install the gem manually:

```bash
gem install flash
```

or add it to your Gemfile:

```ruby
group :development do
  gem 'flash'
end
```

## Usage

Flash requires a `.flash.yml` in order to run, which should be defined at the root of your workspace folder; where all your projects live, and where you run _flash commands_.

```
# Example: .flash.yml

projects:
  - ruhoh.rb
  - silly
  - 3.0-feature-walkthrough
  - multimarkdown-example

sample:
  - ruhoh.rb
  - 3.0-feature-walkthrough

aliases:
  update-master: git stash; git checkout master; git pull; git stash pop
  status: git status -s
  branch: git branch

clone:
  git: git@github.com:ruhoh
```

### flash info

```bash
flash info [group]
```

Takes an optional group parameter. Will parse .flash.yml and print the whole .flash.yml, or print a group's description info.

### flash clone

```bash
flash clone [group]
```

Requires a clone/git base url, from where a group of projects can be cloned from. .flash.yml should contain the clone git url setting.

```
# Example: .flash.yml

projects:
  - ruhoh.rb
  - silly

clone:
  git: git@github.com:ruhoh
```

Example:

```bash
flash clone projects
```

### flash run

```bash
flash run [command(s) | alias] [group]
```

The _run_ command is the heart of __flash__. It requires both a command (or commands) and a group. It will parse the .flash.yml based on the specified group, retrieve all projects in that group and then execute same command(s) one at a time per each project.


Command: can either be defined in `aliases` section, or can be a list of commands semi-column separated.

```
# Example: .flash.yml

projects:
  - ruhoh.rb
  - silly
  - 3.0-feature-walkthrough
  - multimarkdown-example

aliases:
  update-master: git stash; git checkout master; git pull; git stash pop
  status: git status -s
  branch: git branch
```


Some examples:

```bash
flash run ls projects
...

flash run "pwd ; ls" projects
...

flash run update-master projects
...
```

## Contributing

- add guide lines

## Notes

This is a project to level up my gem skills.
