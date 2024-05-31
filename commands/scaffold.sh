#! /bin/bash

# The subcommand that scaffolds a new DocGenSpec

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_name>"
    exit 1
fi

# Assigning arguments to variables
directory_name="$1"
github_repo_url="https://github.com/DanielCardonaRojas/DocGenSpec"

# Create a new directory
mkdir -p "$directory_name"

# Initialize an empty git repo
cd "$directory_name" || exit
git init
git branch -M main

# Download the zip file of the GitHub repository
curl -L "$github_repo_url/archive/master.zip" -o repo.zip

# Extract the contents of the zip file
unzip repo.zip
rm repo.zip  # Delete the zip file after extraction

# Move the contents of the unzipped directory to the parent directory
mv DocGenSpec-main/* ./
rm -rf DocGenSpec-main  # Remove the unzipped directory

# Exit
exit 0
