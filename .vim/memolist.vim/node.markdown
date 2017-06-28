<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [node](#node)
- [List](#list)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

node
===

# List

Installed package
```bash
npm list --global --depth=0
npm list --depth=0
```

Installed all package
```bash
npm list --global
npm list
```

Check npm config
```bash
npm config list
```

# Install/Uninstall

install
```bash
npm install <package> [ --global] --save-dev
```

uninstall
```bash
# Remove devDependencies
npm uninstall <package> [ --global] --save
# Remove Dependencies
npm uninstall <package> [ --global] --save-dev
```
