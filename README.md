Flash
=====

[![Gem Version](https://badge.fury.io/rb/flash.svg)](http://badge.fury.io/rb/flash)
[![Build Status](https://travis-ci.org/colmarius/flash.svg?branch=master)](https://travis-ci.org/colmarius/flash?branch=master)

![flash](http://colmarius.net/flash/images/dodgetocat.png)

Hello! This gem is currently under development towards _0.1.0 version_!

Overview
--------

Main purpose of Flash is to eliminate repetitive tasks, those of running the
same commands on multiple directories.

It allows one to define:
- __aliases__ for sets of commands to be run on multiple directories
- __groups__ for grouping together multiple directories

Both groups and aliases can be defined in the `.flash.yml` configuration file.

Motivation
----------

__Simple configuration file__

A place to define both groups and aliases.

__Inspect output__

See the output of flash commands runned on a group of projects. 

Installation
------------

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

Usage
-----

Flash requires a `.flash.yml` file in order to function. This should be
defined at the root of your workspace folder.

```
# .flash.yml

frontend:
  - super-product1
  - super-product2
  - super-api
  - super-sso

libraries:
  - super-rest-client
  - super-core-js
  - super-core-css

aliases:
  update-master: git stash; git checkout master; git pull
  status: git status -s

clone:
  git: git@github.com:SuperDuper
```

Here we define two groups _frontend_ and _libraries_. We will be allowed to run commands on each of these groups.

We can also define two special configuration sections:

- __aliases__: allows us two save repetitive and long commands
- __clone__: allows to define a base __git__ URL from where projects in a group can be cloned

With a valid `.flash.yml` configuration file set in your current workspace you
are now set to run flash commands.

Commands
--------

Running `flash` will give you the following output:

    Commands:
      flash clone GROUP        # Clone all projects found in GROUP config file
      flash help [COMMAND]     # Describe available commands or one specific command
      flash info [GROUP]       # Display information from config file
      flash run COMMAND GROUP  # Run one or more COMMAND(s) on the specified GROUP
      flash version            # Display Flash gem version

### flash clone

    flash clone GROUP

Allows to clone all projects defined in a GROUP by using the clone git base
URL.

Getting back to our `.flash.yml` example file...

```
# .flash.yml

frontend:
  - super-product1
  - super-product2
  - super-api
  - super-sso

...

clone:
  git: git@github.com:SuperDuper
```

Running the following command...

    flash clone frontend

will clone from SuperDuper organization all projects defined in _frontend_
group.

### flash info

    flash info [GROUP]

This is a helper command for printing `.flash.yml` contents. Prints all file
contents or just part of it (depending if group or other config section is
specified).

### flash run

    flash run COMMAND GROUP

The heart of flash is the __run__ command. It requires both a COMMAND and a 
GROUP. With this command one can run same tasks on all projects of same GROUP.

Note: COMMAND can be a standalone command, or be defined in `aliases` section
(where it must be a list of commands, semi-column separated).

Getting back to our `.flash.yml` example file...

```
# .flash.yml

frontend:
  - super-product1
  - super-product2
  - super-api
  - super-sso

libraries:
  - super-rest-client
  - super-core-js
  - super-core-css

aliases:
  update-master: git stash; git checkout master; git pull
  status: git status -s
```

here are some commands you can run:

    # Update master branch.
    flash run update-master frontend
    flash run update-master libraries

    # Display status.
    flash run status frontend

    # List some files.
    flash run ls frontend 

    # Lets push master branch to origin/staging (forced) for all frontend projects.
    flash run "git checkout master ; git checkout -B staging ; git push -f ; git checkout master" frontend

    # This last command could be aliased to `master-to-staging`, which would result in:
    flash run master-to-staging frontend

Contributing
------------

Please see [CONTRIBUTING.md](https://github.com/colmarius/flash/blob/update-docs/CONTRIBUTING.md).

Note
----

This is a project to level up my gem skills.
