#!/bin/bash

# Homebrew maintenance
echo "Updating Homebrew..."
brew update

echo "Checking for outdated packages..."
brew outdated > outdated_packages.txt

echo "Upgrading packages from always_upgrade.txt..."
if [ -f always_upgrade.txt ]; then
    while read -r package; do
        if [ -z "$package" ]; then
            continue
        fi
        if grep -q "^$package " outdated_packages.txt; then
            echo "Upgrading $package..."
            brew upgrade "$package"
        fi
    done < always_upgrade.txt
fi

echo "Done."
