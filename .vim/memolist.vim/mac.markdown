<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Mac](#mac)
  - [homebrew](#homebrew)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Mac
===

Hold down
```
⌘ command + ⌥ option + esc
```

Screen shot
```
⌘ command + Shift + 3
⌘ command + Shift + 4
```

## homebrew

Init
```bash
$ cd $HOME/work/dotfiles/lib
$ brew tap Homebrew/brewdler
$ brew brewdle
$ brew doctor
```

Update
```bash
$ brew update
$ brew upgrade
$ brew doctor
```

Install
```bash
$ brew install <app>
$ cd /tmp
$ brew brewdle dump
$ diff $HOME/work/dotfiles/lib/Brewfile ./Brewfile
```

Delete
```bash
$ brew uses --installed <app>
$ brew uninstall <app>
$ brew doctor
```
