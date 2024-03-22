#! /bin/bash

set -e

# Check environment variable DOCGEN_PATH or defaults to ~/.config/docgen
DOC_CONTEXT="${DOCGEN_PATH:-$HOME/.config/docgen}"

# Pick the document you are trying to generate e.g invoice, CV, report
# This will depend on the folder structure created under the configuration directory

DOC_TYPE=$(ls -d $DOC_CONTEXT/*/ | xargs -L 1 basename | gum choose --header "Pick type of document")
BASE_DIR="$DOC_CONTEXT/$DOC_TYPE"

# Check that required folders exist

if ! [ -d "$BASE_DIR/templates" ]; then
    echo "$BASE_DIR/templates does not exist."
    exit 1
fi

if ! [ -d "$BASE_DIR/data" ]; then
    echo "$BASE_DIR/data does not exist."
    exit 1
fi


# Choose a template file

TEMPLATE_FILE=$(ls $BASE_DIR/templates | tr '\n' ' ' | xargs -L 1 gum choose --header "Pick a template")
TEMPLATE_EXTENSION="${TEMPLATE_FILE##*.}"


# Choose the file containing data to fill the template

VALUE_FILE=$(ls $BASE_DIR/data | tr '\n' ' ' | xargs -L 1 gum choose --header "Pick a template values")

# Create file name
DATE=$(date +'%B_%Y' | tr '[:lower:]' '[:upper:]')
FILE_TYPE=$(echo "$DOC_TYPE" | tr '[:lower:]' '[:upper:]')
OUTPUT_FILE_NAME=$(gum input --value "${FILE_TYPE}_DANIEL_CARDONA_${DATE}.${TEMPLATE_EXTENSION}" --header "Output file name")


# echo "Using template: $TEMPLATE_FILE and filling with $VALUE_FILE dir: $BASE_DIR in $DOC_CONTEXT output filename: $OUTPUT_FILE_NAME"
echo "$BASE_DIR $TEMPLATE_FILE $VALUE_FILE $OUTPUT_FILE_NAME"
