#!/bin/bash

# Define the default directory where you want to clone the repository
default_doc_gen_spec_dir="$HOME/.local/share/docgen/"
default_doc_gen_dir="$HOME/.config/docgen/"

# Define the directory where you want to clone the repository, using environment variable if set, otherwise default
clone_dir="${DOCGEN_SPEC_PATH:-$default_doc_gen_spec_dir}"
doc_gen_dir="${DOCGEN_PATH:-$default_doc_gen_dir}"

# Check if the directory exists, if not, create it
if [ ! -d "$clone_dir" ]; then
    mkdir -p "$clone_dir"
fi

# Check if the repository URL is provided as a command-line argument
if [ -z "$1" ]; then
    echo "Error: Repository URL not provided."
    exit 1
fi

repo_url="$1"

# Clone the repository into the specified directory
git -C "$clone_dir" clone "$repo_url" 

repository_name=$(basename "$repo_url" .git)

# Change directory to the cloned repository
cd "$clone_dir$repository_name" || exit

# Fetch tags from the remote repository
git fetch --tags

# Get the latest tag
latest_tag=$(git describe --tags `git rev-list --tags --max-count=1`)

if [ -n "$latest_tag" ]; then
    # Checkout the latest tag
    git checkout "$latest_tag"
    echo "Checked out latest tag: $latest_tag"
else
    # If no tags are found, default to main branch
    git checkout main
    echo "No tags found. Checked out main branch."
fi

