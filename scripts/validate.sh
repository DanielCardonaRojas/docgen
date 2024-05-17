# The subcommand that validates that a DocGen has the correct file structure.

BASE_DIR=$1
set -e

function file_name_exists() {
    local file_name=$1
    local directory=$2
    find $BASE_DIR/$directory -type f -name "$file_name.*" | grep -q '.'
}

function validate_file() {
    local file_name=$1
    local directory=$2

    if ! file_name_exists "$file_name" "$directory" ; then
        echo "Error: $file_name not found in $BASE_DIR/$directory"
        exit 1
    fi
}

function validate_directory() {
    local directory=$1
    if [ ! -d "$BASE_DIR/$directory" ]; then
        echo "Error: $directory not found"
        exit 1
    fi
}


validate_directory "data"
validate_directory "templates"
validate_directory "configs"

validate_file "default" "configs"
validate_file "example" "data"
validate_file "default" "templates"



