# goto

Change to a directory and list its content using an alias. Aliases are defined as environment variables, hence auto-completed by default.

*What's the point?* Sometimes projects with complex directory structure have key places from which you run build/tests/you name it. It's very convenient to be able to jump there from any point of the tree.

*Why not `cd` instead?* You can always use `cd` over goto with defined aliases (remember it's only a variable). The goto's added value is its ability to manage the aliases. If you are like me, you tend to forget, a lot, so goto has a command that reminds you what aliases you already have.

## Installation

```
# Clone the repository
$ git clone https://github.com/antagon/goto

# Copy the script in your home directory
$ cp goto/goto.sh ~/.goto

# Put bootstrap code in your .bashrc
$ cat goto/setup.sh >> ~/.bashrc

# Reload .bashrc
$ source ~/.bashrc
```

## Usage

### Add directory aliases

```
$ goto_edit
git="~/git"
git_goto="$git/antagon/goto"
desktop="~/Desktop"
downloads="~/Downloads"
images="~/Images"
```

The command will open default EDITOR (as defined in environment variable
`$EDITOR`) and reloads the file after it's closed. Aliases are defined as
environment variables.

### List existing aliases

```
$ goto_list
$desktop         ~/Desktop
$downloads       ~/Downloads
$git             ~/git
$git_goto        ~/git/antagon/goto
$images          ~/Images
```

The command lists defined directory aliases.

### Go to directory

```
$ goto $desktop
total 0
-rw-r--r-- 1 user user 0 Jun  6 13:59 readme.txt
```

The command will switch to `~/Desktop` directory and list its content.

### Reload directory aliases

```
$ goto_reload
```

The command will reload alias file. This is useful when you have edited the file without use of `goto_edit`.

### Shorthand commands

In `setup.sh` there are default aliases for your shell that you may find useful when using goto. If you do not want to use them, either delete them from `setup.sh`, or your `~/.bashrc`.

A shorthand for `goto`.

```
$ g $desktop
total 0
-rw-r--r-- 1 user user 0 Jun  6 13:59 readme.txt
```

A shorthand for `goto_list`.

```
$ gl
$desktop         ~/Desktop
$downloads       ~/Downloads
$git             ~/git
$git_goto        ~/git/antagon/goto
$images          ~/Images
```

### $alias/path support

Since variables ($alias) is expanded to its value, before being passed to goto, it's perfectly fine to use:

```
$ g /etc/ssh

# Switch to home dir
$ g ~

# Combine $alias with arbitrary strings (switch to ~/git/dockerfiles)
$ g $git/dockerfiles
```

