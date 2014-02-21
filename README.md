# Flash

Flash helps you run arbitrary or predefined commands on multiple projects all defined in the Runfile.

# Installation

```bash
> gem install flash
```

The command available is run:

```bash
> run
Group name is missing.
Usage: run command group
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
```

Now we can use the `run` command to execute same commands on a subset of folders.

```bash
> run -c ls projects
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
