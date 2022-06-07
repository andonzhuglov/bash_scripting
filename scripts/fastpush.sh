#!/bin/bash

echo "Which file/s would you like to push?"

read -p -e files

echo "What is the commit comment?"

read comment

git add $files
git commit -m "$comment"
git push

