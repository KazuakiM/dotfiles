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
