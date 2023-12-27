#!/bin/bash

# Check if the target directory is provided as an argument
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <organization-name> <target-directory>"
    exit 1
fi

# Set your organization name from the first argument
ORG_NAME="$1"

# Set the target directory from the second argument
TARGET_DIR="$2"
mkdir -p "$TARGET_DIR"

# Fetch list of repositories from the organization
# and clone each one
gh repo list "$ORG_NAME" --limit 1000 | while read -r repo _; do
    echo "Cloning $repo..."
    gh repo clone "$repo" "$TARGET_DIR/$(basename $repo)"
done

echo "Cloning completed."

# Usage
# ./clone-all-repos-in-organisation.sh <organization-name> <target-directory>