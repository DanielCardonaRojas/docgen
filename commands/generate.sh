#! /bin/bash

# The subcommand that generates new documents.

set -e

# CHECK ENVIRONMENT VARIABLE DOCGEN_PATH OR DEFAULTS TO ~/.CONFIG/DOCGEN
DOC_CONTEXT="${DOCGEN_SPEC_PATH:-$HOME/.local/share/docgen}"

# PICK THE DOCUMENT YOU ARE TRYING TO GENERATE E.G INVOICE, CV, REPORT
# THIS WILL DEPEND ON THE FOLDER STRUCTURE CREATED UNDER THE CONFIGURATION DIRECTORY

DOC_TYPE=$(ls -d $DOC_CONTEXT/*/ | xargs -L 1 basename | gum choose --header "Pick type of document")
BASE_DIR="$DOC_CONTEXT/$DOC_TYPE"

# CHOOSE THE CONFIG TO USE

CONFIG_FILE=$(ls $BASE_DIR/configs | head -n 1)

CONFIG_FILE_COUNT=$(ls $BASE_DIR/configs | wc -l | tr -s ' ')

if [ "$CONFIG_FILE_COUNT" -gt 1 ]; then
    CONFIG_FILE=$(ls $BASE_DIR/configs | tr '\n' ' ' | xargs -L 1 gum choose --header "Pick a config")
fi

CURRENT_DIR="$(pwd)"
cd "$BASE_DIR"

# IS THERE A SCRIPT THAT CAN CALCULATE THE OUTPUT FILE NAME?

SPEC_NAME=$(basename "$BASE_DIR")
FILENAME="${SPEC_NAME%Spec}"



if [ -f "$BASE_DIR/scripts/doc_gen_file_name.sh" ]; then
    FILENAME=$(bash "$BASE_DIR/scripts/doc_gen_file_name.sh")
else
    echo "No automatic output file name for template"
fi

# echo "Spec: $SPEC_NAME file: $FILENAME current dir: $CURRENT_DIR"


# Choose the data file in case more than one is present
EXAMPLE_FILE_PATH=$(find $BASE_DIR/data -type f -name "example.*")
EXAMPLE_FILE=$(basename "$EXAMPLE_FILE_PATH")
EXAMPLE_FILE_EXTENSION="${EXAMPLE_FILE##*.}"

DATA_FILES=$(ls $BASE_DIR/data | grep -v -e "example" | grep "$EXAMPLE_FILE_EXTENSION")
DATA_FILES_COUNT=$(echo "$DATA_FILES" | wc -l | tr -s ' ')

DATA_FILE="default.$EXAMPLE_FILE_EXTENSION"

if [ "$DATA_FILES_COUNT" -gt 1 ]; then
    DATA_FILE=$(echo "$DATA_FILES" | tr '\n' ' ' | xargs -L 1 gum choose --header "Pick a data file")
fi

# WRITE TO A SPECIFIC FILE NAME OR TO STDOUT

if [ -n "$FILENAME" ]; then
    echo "Writing to: $CURRENT_DIR/$FILENAME"
    gomplate --config="$BASE_DIR/configs/$CONFIG_FILE" -d data="$BASE_DIR/data/$DATA_FILE" -o - > "$CURRENT_DIR/$FILENAME"
else
    gomplate --config="$BASE_DIR/configs/$CONFIG_FILE" -d data="$BASE_DIR/data/$DATA_FILE" -o -
fi


# CLEANUP
if [ -f "$BASE_DIR/scripts/doc_gen_cleanup.sh" ]; then
    bash "$BASE_DIR/scripts/doc_gen_cleanup.sh"
else
    echo "No cleanup required"
fi
