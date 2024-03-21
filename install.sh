#!/bin/bash

# Get the absolute path of the directory where the script is located
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Loop through the scripts in the directory and create aliases for .sh and .py files
for script in "$SCRIPTS_DIR"/*.sh "$SCRIPTS_DIR"/*.py; do
    # Skip files containing "*install*" in their names
    if [[ "$(basename "$script")" == *install* ]]; then
        continue
    fi
    
    # Proceed with alias creation for non-install scripts
    if [ -x "$script" ]; then
        script_name=$(basename "$script")
        script_absolute_path=$(realpath "$script")
        echo "Adding alias for '$script_name'"
        echo "alias ${script_name%.*}=\"$script_absolute_path\"" >> "$HOME/.bashrc"
    fi
done

# Source the .bashrc file to apply changes
source "$HOME/.bashrc"

echo "Installation complete. Make sure to restart your terminal or run 'source ~/.bashrc' to apply changes."

