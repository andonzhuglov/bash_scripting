#!/bin/bash

echo "Which file/s would you like to push?"

readme files

echo "What is the commit comment?"

readme comment

git add $files
git commit -m "$comment"
git push

