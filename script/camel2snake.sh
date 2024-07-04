#! /bin/bash

set -euo pipefail

for f in *graphql; do
    if [ $f = "index.graphql" ]; then
       continue
    else
        before=${f%.graphql}
        after=`echo $before | sed -E 's/(.)([A-Z])/\1_\2/g' | awk '{print tolower($0)}'`
        sed -i -e "s/$before/$after/g" $f
        sed -i -E "s/^  $before\(/  $after(/g" index.graphql
        sed -i -E "s/\[$before\]/\[$after\]/g" index.graphql
        mv $f $after.graphql
    fi
done
