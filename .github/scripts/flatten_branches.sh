#!/bin/bash

# Start by getting all templates currently on main branch in content repo
find ./src/content -type f -name '*.md' -or -name '*.njk' \
| jq -R '[inputs]' > ./src/_data/published.json

# Now go to the content repo and flatten it
cd ./src/content || exit
git config --global user.name "GitHub Actions"
git config --global user.email "github-actions@github.com"
for branch in $(git for-each-ref --format='%(refname)' refs/remotes/); do
    if [ "$branch" != 'refs/remotes/origin/main' ]; then
        short_branch="$(echo "$branch" | cut -d'/' -f 4)"
        git merge -m 'Automerge' "origin/$short_branch"
    fi
done
