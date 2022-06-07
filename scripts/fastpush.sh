#!/bin/bash

printf "Files in current directory $pwd are:\n"
ls
printf "\n"
read -e -p "Select files for push: " files
echo "Files selected for push $files"
read -p "What is the commit comment? " comment

git add $files
git commit -m "$comment"
git push

