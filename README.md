# macOS Maintenance Script

This script provides a basic maintenance routine for macOS, focusing on keeping Homebrew packages up-to-date.

![GitHub last commit](https://img.shields.io/github/last-commit/jwalker/macos-updater)
![GitHub repo size](https://img.shields.io/github/repo-size/jwalker/macos-updater)
![GitHub issues](https://img.shields.io/github/issues/jwalker/macos-updater)

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
