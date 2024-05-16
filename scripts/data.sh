#!/bin/bash

# The subcommand that create new data files based on examples for the template
# to populate templates with custom information.


DOC_GEN_SPEC_DIR="${DOCGEN_SPEC_PATH:-$HOME/.local/share/docgen}"
DOC_GEN_DIR="${DOCGEN_PATH:-$HOME/.config/docgen}"

# PICK THE DOCUMENT YOU ARE TRYING TO GENERATE E.G INVOICE, CV, REPORT
# THIS WILL DEPEND ON THE FOLDER STRUCTURE CREATED UNDER THE CONFIGURATION DIRECTORY

if [ ! -d "$DOC_GEN_SPEC_DIR" ]; then
    echo "No available specs"
    exit 1
fi

DOC_TYPE=$(ls -d $DOC_GEN_SPEC_DIR/*/ | xargs -L 1 basename | gum choose --header "Pick type of document")
SPEC_DIR="$DOC_GEN_SPEC_DIR/$DOC_TYPE/data"
MIRROR_DIR="$DOC_GEN_DIR/$DOC_TYPE/data"

# Create a mirror of the data folder of the spec in ~/.config/docgen/<SPEC_NAME>/data

if [ ! -d "$MIRROR_DIR" ]; then
    mkdir -p "$MIRROR_DIR"
fi

# Duplicate the examples file and symlink

EXAMPLE_FILE_PATH=$(find $SPEC_DIR -type f -name "example.*")
EXAMPLE_FILE=$(basename "$EXAMPLE_FILE_PATH")
EXAMPLE_FILE_EXTENSION="${EXAMPLE_FILE##*.}"
FILE_NAME="default.$EXAMPLE_FILE_EXTENSION"

if [ ! -f "$MIRROR_DIR/default.$EXAMPLE_FILE_EXTENSION" ]; then
    cp "$EXAMPLE_FILE_PATH" "$MIRROR_DIR/$FILE_NAME"
    ln -s "$MIRROR_DIR/$FILE_NAME" "$SPEC_DIR/$FILE_NAME"
else
    NAME=$(gum input --placeholder "Please provide a name for data file")
    FILE_NAME="$NAME.$EXAMPLE_FILE_EXTENSION"
    cp "$EXAMPLE_FILE_PATH" "$MIRROR_DIR/$FILE_NAME"
    ln -s "$MIRROR_DIR/$FILE_NAME" "$SPEC_DIR/$FILE_NAME"
fi


