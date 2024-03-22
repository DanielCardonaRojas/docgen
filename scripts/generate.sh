#! /bin/bash


PWD=$(pwd)
args=$(bash "$PWD/scripts/choose_options.sh")

BASE_DIR=$(echo "$args" | awk '{print $1}')
TEMPLATE_FILE=$(echo "$args" | awk '{print $2}')
VALUE_FILE=$(echo "$args" | awk '{print $3}')
OUTPUT_FILE=$(echo "$args" | awk '{print $4}')

gomplate -d data=$BASE_DIR/data/$VALUE_FILE -f $BASE_DIR/templates/$TEMPLATE_FILE > $OUTPUT_FILE

