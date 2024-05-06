#! /bin/bash

set -e

# CHECK ENVIRONMENT VARIABLE DOCGEN_PATH OR DEFAULTS TO ~/.CONFIG/DOCGEN
DOC_CONTEXT="${DOCGEN_PATH:-$HOME/.config/docgen}"

# PICK THE DOCUMENT YOU ARE TRYING TO GENERATE E.G INVOICE, CV, REPORT
# THIS WILL DEPEND ON THE FOLDER STRUCTURE CREATED UNDER THE CONFIGURATION DIRECTORY

DOC_TYPE=$(ls -d $DOC_CONTEXT/*/ | xargs -L 1 basename | gum choose --header "Pick type of document")
BASE_DIR="$DOC_CONTEXT/$DOC_TYPE"

# CHOOSE THE CONFIG TO USE

CONFIG_FILE=$(ls $BASE_DIR/configs | tr '\n' ' ' | xargs -L 1 gum choose --header "Pick a config")

CURRENT_DIR="$(pwd)"
echo "current working directory: $CURRENT_DIR"
cd "$BASE_DIR"

# IS THERE A SCRIPT THAAT CAN CALCULATE THE OUTPUT FILE NAME?

FILENAME=""
if [ -f "$BASE_DIR/scripts/file_name.sh" ]; then
    FILENAME=$(bash "$BASE_DIR/scripts/file_name.sh")
else
    echo "No automatic output file name for template"
fi


# WRITE TO A SPECIFIC FILE NAME OR TO STDOUT

if [ -n "$FILENAME" ]; then
    echo "writting to: $CURRENT_DIR/$FILENAME"
    gomplate --config="$BASE_DIR/configs/$CONFIG_FILE" -o - > "$CURRENT_DIR/$FILENAME"
else
    gomplate --config="$BASE_DIR/configs/$CONFIG_FILE" -o -
fi

