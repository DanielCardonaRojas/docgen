#! /bin/bash

DIR=$(realpath $0 | xargs dirname)
source "$DIR/completions.sh"
default_doc_gen_dir="$HOME/.config/docgen/"
doc_gen_dir="${DOCGEN_PATH:-$default_doc_gen_dir}"
cd $doc_gen_dir
$EDITOR

