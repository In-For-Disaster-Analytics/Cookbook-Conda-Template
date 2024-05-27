#!/bin/bash
# $1: input file
# $2: output file

if [ "$#" -ne 2 ]; then
    echo "Usage: run.sh <input_file> <output_file>"
    exit 1
fi

# Run the main.py file with the input and output file
python main.py ${1} ${WORK}/output.txt