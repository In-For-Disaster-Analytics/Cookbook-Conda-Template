#!/bin/bash
# $1: input file

if [ "$#" -ne 1 ]; then
    echo "Usage: run.sh <input_file>"
    exit 1
fi

# Run the main.py file with the input and output file
python main.py ${1} ${WORK}/output.txt