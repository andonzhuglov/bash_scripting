#!/bin/bash

R='\033[0;31m'
C='\033[0;36m'
Y='\033[1;33m'
G='\033[1;32m'
W='\033[0;37m'
NC='\033[0m'
fzfBin=$(which fzf)

export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'"



function print { echo -e "${G}[OK] ${W}${1}${NC}"; }
function error { echo -e "${R}[ERROR] ${Y}${1}${NC}"; }
function warning { echo -e "${Y}[WARN] ${W}${1}${NC}"; }
function info { echo -e "${C}[INFO] ${W}${1}${NC}";}
trap "$(warning 'Caught INT signal. Bye!')" SIGINT SIGTERM

test -x $fzfBin || { error "fzf not found. Please install it first."; exit 1; }
test -d .git || { error "No git repository in this folder. Exiting!"; exit 1; }

function addFiles {
    info "Please select files to push to remote:"
    local files=$(git status --porcelain | awk '{print $2}' | $fzfBin --multi --preview 'git diff --color=always {}')
    for file in $files; do
        git add $file
        print "Added $file"
    done
}

function pushChanges {
    info "Select branch to push to:"
    local remoteBranch=$(git branch -r | awk '{print $1}' | $fzfBin)
    read -p "Commit message: " commitMessage
    git commit -m "$commitMessage"
    #git push origin $remoteBranch
    if [[ "${?}" -eq 0 ]] ; then print "Pushed to $remoteBranch" || error "Failed to push to $remoteBranch"; fi
}

addFiles
pushChanges
unset FZF_DEFAULT_OPTS

