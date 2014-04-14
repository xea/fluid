#!/bin/sh
 
git filter-branch -f --env-filter '
 
an="$GIT_AUTHOR_NAME"
am="$GIT_AUTHOR_EMAIL"
cn="$GIT_COMMITTER_NAME"
cm="$GIT_COMMITTER_EMAIL"
 
if [ "$GIT_COMMITTER_EMAIL" = "--global" ]
then
    cn="Alex Pécsi"
    cm="xea@remalomfold.hu"
fi
if [ "$GIT_AUTHOR_EMAIL" = "--global" ]
then
    an="Alex Pécsi"
    am="xea@remalomfold.hu"
fi
 
export GIT_AUTHOR_NAME="$an"
export GIT_AUTHOR_EMAIL="$am"
export GIT_COMMITTER_NAME="$cn"
export GIT_COMMITTER_EMAIL="$cm"
'
