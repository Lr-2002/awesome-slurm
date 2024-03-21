#!/bin/zsh

# Get the absolute path of the directory where the install.sh script is located
SCRIPTS_DIR="$( cd "$( dirname "${(%):-%N}" )" >/dev/null 2>&1 && pwd )"

# Loop through the scripts in the directory and create aliases for .sh and .py files
for script in "$SCRIPTS_DIR"/*.sh "$SCRIPTS_DIR"/*.py; do
    # Extract just the filename without extension
    script_name=$(basename "$script:r")
    
    # Skip the script if its name contains "install" anywhere
    if [[ "$script_name" == *install* ]] && [ -x "$script" ]; then
        continue
    fi
    
    # If not skipped, proceed with alias creation
    script_absolute_path=$(realpath "$script")
    echo "Adding alias for '$script_name'"
    echo "alias $script_name=\"$script_absolute_path\"" >> "$HOME/.zshrc"
done

# Source the .zshrc file to apply changes
source "$HOME/.zshrc"

echo "Installation complete. Make sure to restart your terminal or run 'source ~/.zshrc' to apply changes."

