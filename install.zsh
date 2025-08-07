#!/bin/zsh

# The name of the plist file for the launchd job
PLIST_NAME="com.user.macmaintenance.plist"
# The name of the template file
PLIST_TEMPLATE_NAME="com.user.macmaintenance.plist.template"
# The directory where launchd plists are stored for the user
LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"
# The absolute path to the directory containing this script
SCRIPT_DIR=$(cd -- "$(dirname -- \"$0\")" && pwd)
# The full path to the source plist template file in this project
SOURCE_PLIST_TEMPLATE_PATH="$SCRIPT_DIR/$PLIST_TEMPLATE_NAME"
# The full path to where the plist file will be installed
TARGET_PLIST_PATH="$LAUNCH_AGENTS_DIR/$PLIST_NAME"

# --- Functions ---

# Installs the launchd job
install_job() {
    echo "Installing scheduled task..."
    if [ ! -f "$SOURCE_PLIST_TEMPLATE_PATH" ]; then
        echo "ERROR: Plist template file not found at $SOURCE_PLIST_TEMPLATE_PATH"
        exit 1
    fi
    
    # Create the LaunchAgents directory if it doesn't exist
    if [ ! -d "$LAUNCH_AGENTS_DIR" ]; then
        echo "Creating directory: $LAUNCH_AGENTS_DIR"
        mkdir -p "$LAUNCH_AGENTS_DIR"
    fi
    
    echo "Generating plist file from template..."
    # Replace the placeholder with the actual path to the script directory
    sed "s|%%MACOS_UPDATER_PATH%%|$SCRIPT_DIR|g" "$SOURCE_PLIST_TEMPLATE_PATH" > "$TARGET_PLIST_PATH"
    
    echo "Loading launchd job..."
    launchctl load "$TARGET_PLIST_PATH"
    
    echo "
Installation complete. The script will run daily at 5 AM."
}

# Removes the launchd job
remove_job() {
    echo "Removing scheduled task..."
    if [ ! -f "$TARGET_PLIST_PATH" ]; then
        echo "Task not found. Nothing to remove."
        exit 0
    fi
    
    echo "Unloading launchd job..."
    launchctl unload "$TARGET_PLIST_PATH"
    
    echo "Removing plist file..."
    rm "$TARGET_PLIST_PATH"
    
    echo "
Removal complete."
}

# Disables the launchd job by unloading it
disable_job() {
    echo "Disabling scheduled task..."
    if [ ! -f "$TARGET_PLIST_PATH" ]; then
        echo "Task not found. Nothing to disable."
        exit 0
    fi
    
    echo "Unloading launchd job..."
    launchctl unload "$TARGET_PLIST_PATH"
    
    echo "
Task disabled. To re-enable it, run: ./install.zsh install"
}

# --- Main Logic ---

# Display help if no arguments are provided
if [ -z "$1" ]; then
    echo "Usage: ./install.zsh [install|remove|disable]"
    echo "  install   - Copies the plist and loads the scheduled task."
    echo "  remove    - Unloads the task and deletes the plist file."
    echo "  disable   - Unloads the task without deleting the plist file."
    exit 1
fi

# Process the command
case "$1" in
    install)
        install_job
        ;;
    remove)
        remove_job
        ;;
    disable)
        disable_job
        ;;
    *)
        echo "Invalid command: $1"
        echo "Usage: ./install.zsh [install|remove|disable]"
        exit 1
        ;;
esac

exit 0
