#!/bin/bash

# This script creates new data file to populate a template.


DOC_CONTEXT="${DOCGEN_PATH:-$HOME/.config/docgen}"

# PICK THE DOCUMENT YOU ARE TRYING TO GENERATE E.G INVOICE, CV, REPORT
# THIS WILL DEPEND ON THE FOLDER STRUCTURE CREATED UNDER THE CONFIGURATION DIRECTORY

DOC_TYPE=$(ls -d $DOC_CONTEXT/*/ | xargs -L 1 basename | gum choose --header "Pick type of document")
BASE_DIR="$DOC_CONTEXT/$DOC_TYPE"

# Duplicate the examples file
EXAMPLE_FILE_PATH=$(find $BASE_DIR/data -type f -name "example.*")
EXAMPLE_FILE=$(basename "$EXAMPLE_FILE_PATH")
EXAMPLE_FILE_EXTENSION="${EXAMPLE_FILE##*.}"

if [ ! -f "$BASE_DIR/data/default.$EXAMPLE_FILE_EXTENSION" ]; then
    cp "$EXAMPLE_FILE_PATH" "$BASE_DIR/data/default.$EXAMPLE_FILE_EXTENSION"
else
    FILE_NAME=$(gum input --placeholder "Please provide a name for data file")
    cp "$EXAMPLE_FILE_PATH" "$BASE_DIR/data/$FILE_NAME.$EXAMPLE_FILE_EXTENSION"
fi


