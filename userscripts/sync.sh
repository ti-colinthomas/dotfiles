#!/bin/bash

# Define the source (development) and destination (Min browser) directories
SOURCE_DIR="/Users/colin/dotfiles/userscripts"
DEST_DIR="/Users/colin/Library/Application Support/Min/userscripts"

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Source directory '$SOURCE_DIR' not found."
  exit 1
fi

# Check if the destination directory exists. Create it if it doesn't.
if [ ! -d "$DEST_DIR" ]; then
  echo "Destination directory '$DEST_DIR' does not exist. Creating it now..."
  mkdir -p "$DEST_DIR"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to create destination directory '$DEST_DIR'."
    exit 1
  fi
fi

# If SOURCE_DIR is empty, also clear the DEST_DIR
if ! fd -e js -d 1 --full-path "$SOURCE_DIR" | grep -q .; then
  cd "$DEST_DIR"
  rm -rfv *.js
fi

echo "Creating symlinks from '$SOURCE_DIR' to '$DEST_DIR'..."
echo "---"

# Iterate over each .js file in the source directory
for script_file in "$SOURCE_DIR"/*.js; do
  # Check if any .js files were found
  if [ -e "$script_file" ]; then
    script_name=$(basename "$script_file")
    dest_path="$DEST_DIR/$script_name"

    # Remove existing symlink or file in destination to avoid conflicts
    if [ -L "$dest_path" ]; then
      echo "Removing existing symlink: $dest_path"
      rm "$dest_path"
    elif [ -f "$dest_path" ]; then
      echo "Warning: Regular file '$dest_path' exists and will be overwritten by symlink."
      rm "$dest_path"
    fi

    # Create the new symlink
    ln -s "$script_file" "$dest_path"
    if [ $? -eq 0 ]; then
      echo "Created symlink: $script_file -> $dest_path"
    else
      echo "Error: Failed to create symlink for $script_file"
    fi
  fi
done

echo "---"
echo "Symlink creation process complete."
echo "You may need to restart Min browser for changes to take effect."
