# Flash

Flash helps you run arbitrary or predefined commands on multiple projects all defined in the Runfile.

# Installation

```bash
> gem install flash
```

The command available is run:

Usage:

```bash
> run [command(s)|alias] [group]
```

```bash
> run
ERROR: Command and Group are missing.
```

# Example


```bash
> cd example
```

Suppose we have a `Runfile` inside the `example` folder with content:

```bash
projects:
  - salsa
  - dancing
  - school

some:
  - salsa
  - school

aliases:
  update-master: git stash; git checkout master; git pull; git stash pop
  status: git status -s
  branch: git branch

# FUTURE: I want to be able to clone repos too
clone:
  github: git@github.com:Awesome

```

Projecs and some are two groups that refer to a subset of folders (or project repos).

Now we can use the `run` command to execute same commands on a subset of folders.

```bash
> run ls projects
salsa> ls
cubana

dancing> ls
bouncing

school> ls
fun

```

# Notes

This is a project to level up my gem skills.

TODO: write detailed description
