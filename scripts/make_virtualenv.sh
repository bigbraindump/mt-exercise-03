#! /bin/bash

# virtualenv must be installed on your system, install with e.g.
# pip install virtualenv

scripts=$(dirname "$0")
base=$scripts/..

mkdir -p $base/venvs

# python3 needs to be installed on your system

"/c/Users/sarah/AppData/Local/Programs/Python/Python310/python.exe" -m virtualenv -p "/c/Users/sarah/AppData/Local/Programs/Python/Python310/python.exe" $base/venvs/torch3

# changed to '/Scripts/activate' from '/bin/activate' for windows system    
echo "To activate your environment:"
echo "    source $base/venvs/torch3/Scripts/activate"
