<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [homebrew](#homebrew)
  - [Update](#update)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

homebrew
===

## Update

Basic
```bash
brew update && brew upgrade && brew cleanup && brew cask cleanup && brew doctor && brew cask doctor;
```

Version lock
```bash
brew pin <formula>
brew unpin <formula>
```

If 1 fomula upgrade error, I upgrade other fomula. So Check upgrade list.
```bash
brew outdated
```
