#!/bin/bash


# process substitution example:
ueberzug layer --parser bash 0< <(
    declare -Ap add_command=([action]="add" [identifier]="example0" [x]="0" [y]="0" [path]="$1")
    sleep 5
    declare -Ap remove_command=([action]="remove" [identifier]="example0")
)

# group commands example:
{
    declare -Ap add_command=([action]="add" [identifier]="example0" [x]="0" [y]="0" [path]="$1")
    read
    declare -Ap remove_command=([action]="remove" [identifier]="example0")
    read
} | ueberzug layer --parser bash


# cd ~/Pictures
# ./ueberzug_test.sh IMG_8321.jpg
