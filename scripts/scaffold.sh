#! /bin/bash

DOC_CONTEXT="${DOCGEN_PATH:-$HOME/.config/docgen}"
DOC_TYPE=$1

if [ -d $DOC_CONTEXT/$DOC_TYPE ]; then
    echo "$DOC_CONTEXT/$DOC_TYPE already exists choose different name"
    exit 1
fi

mkdir -p $DOC_CONTEXT/$DOC_TYPE/templates
mkdir -p $DOC_CONTEXT/$DOC_TYPE/data

echo "created folder structure at: $DOC_CONTEXT/$DOC_TYPE"

