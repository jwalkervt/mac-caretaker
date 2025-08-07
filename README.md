# macOS Maintenance Script

This script provides a basic maintenance routine for macOS, focusing on keeping Homebrew packages up-to-date.

![GitHub last commit](https://img.shields.io/github/last-commit/jwalkervt/mac-caretaker)
[![License](https://img.shields.io/github/license/jwalkervt/mac-caretaker)](LICENSE)
![Top language](https://img.shields.io/github/languages/top/jwalkervt/mac-caretaker)
[![ShellCheck](https://github.com/jwalkervt/mac-caretaker/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/jwalkervt/mac-caretaker/actions/workflows/shellcheck.yml)

## Features

- Updates Homebrew.
- Logs outdated packages.
- Automatically upgrades packages specified in `always_upgrade.txt`.
- Schedules nightly execution using `launchd`.

## Usage

1.  Clone the repository.
2.  Customize the `always_upgrade.txt` file with the packages you want to upgrade automatically.
3.  Move the `com.user.macmaintenance.plist` file to `~/Library/LaunchAgents/`.
4.  Load the `launchd` job: `launchctl load ~/Library/LaunchAgents/com.user.macmaintenance.plist`
