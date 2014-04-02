[![Build Status](https://travis-ci.org/colmarius/flash.svg?branch=0.1.0)](https://travis-ci.org/colmarius/flash)

Flash helps you run arbitrary commands on multiple projects. Both projects and commands are defined in the Runfile.

## Installation

You can either install the gem manually:

```bash
gem install flash
```

or add the gem to Gemfile:

```ruby
group :development do
  gem 'flash'
end
```

## Usage

Flash requires a `Runfile` in order to run, which should be defined at the root of your workspace folder. There where all your projects live, and where you run _flash commands_.

```
# Example: Runfile

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

Takes an optional group parameter. Will parse Runfile and print the whole Runfile or a group description's info.

### flash clone

```bash
flash clone [group]
```

Requires a clone/git base url, from where a group of projects can be cloned from. Runfile should contain the clone git url setting.

```
# Example: Runfile

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
flash clone [command(s) | alias] [group]
```

The _run_ command is the heart of __flash__. It requires both a command (or commands) and a group. It will parse the Runfile based on the specified group, retrieve all projects in that group and then execute same command(s) one at a time per each project.


Command: can be either defined in aliases, or a list of commands semi column separated.

```
# Example: Runfile

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

## TODO

- add change log, maybe separate file

## Notes

This is a project to level up my gem skills.
