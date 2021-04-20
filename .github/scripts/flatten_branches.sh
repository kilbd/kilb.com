#!/bin/bash

# Start by getting all templates currently on main branch in content repo
find ./src/content -type f -name '*.md' -or -name '*.njk' \
| jq -R '[inputs]' > ./src/_data/published.json

# Now go to the content repo and flatten it
cd ./src/content || exit
for branch in $(git for-each-ref --format='%(refname)' refs/heads/); do
    if [ "$branch" != 'refs/heads/main' ]; then
        git merge "$branch"
    fi
done
