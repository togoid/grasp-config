#! /bin/bash
set -euo pipefail

usage() {
    echo "Usage: $0 <ID_TSV> <CONFIG_DIR> [URL]"
    echo "  ID_TSV     : dataset-example_id.tsv"
    echo "  CONFIG_DIR : grasp config directory"
    echo "  URL        : GraphQL API URL (default: https://dx.dbcls.jp/grasp-togoid)"
    exit 1
}

if [ $# -lt 2 ]; then
    usage
fi

ID_TSV=$1
CONFIG_DIR=$2
URL=${3:-"https://dx.dbcls.jp/grasp-togoid"}

DATASET_LIST=($(ls "$CONFIG_DIR" | sed 's/\.[^.]*$//'))

cat $ID_TSV | while read ds id ;
do
    if [[ " ${DATASET_LIST[@]} " =~ " ${ds} " ]]; then
        QUERY="query {
 $ds(id: \\\"$id\\\") {
    label
  }
}"

        QUERY="$(echo $QUERY)"
        # echo $QUERY
        curl -sS -X POST -H "Content-Type: application/json" -d "{ \"query\": \"$QUERY\"}" $URL | jq -c --arg id "$id" '{id: $id, data: .data}'
    fi
done
