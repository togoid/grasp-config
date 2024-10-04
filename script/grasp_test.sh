#! /bin/bash
set -euo pipefail

INPUT=$1
cat $1 | while read ds id ;
do
    # ds=$(echo "$ds" | awk -F_ '{s=""; for(i=1; i<=NF; i++) s=s toupper(substr($i,1,1)) tolower(substr($i,2));print s}')
    QUERY="query {
 $ds(id: \\\"$id\\\") {
    label
  }
}"

#$(sed "s/_DATASET_/$ds/g;s/_ID_/$id/g" query.gql)
    QUERY="$(echo $QUERY)"
    echo $QUERY
    curl -X POST -H "Content-Type: application/json" -d "{ \"query\": \"$QUERY\"}" https://rdfportal.org/grasp-togoid
done
