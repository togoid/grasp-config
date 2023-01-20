#!/usr/bin/env zsh

INPUT=$1
TOGOID_DIR=$2

if [[ $TOGOID_DIR = "" ]]; then
    echo "usage: make_togoid_model_yaml.sh [datasets id-label tsv (datasets.tsv)] [togoid-config dir]"
    exit
fi

declare -a DS_LIST
declare -A DS_LABEL

while read line
do
    ID=`echo $line | cut -f1`
    LABEL=`echo $line | cut -f2`
    DS_LIST=("${DS_LIST[@]}" "${ID}")
    DS_LABEL[$ID]=$LABEL
done < $INPUT

for SRC in "${DS_LIST[@]}"
do
    F=0
    YAML=""
    for TRG in "${DS_LIST[@]}"
    do
	if [ -e "${TOGOID_DIR}/config/${SRC}-${TRG}" ]; then
	    TERM="forward"
	    F_NAME="${SRC}-${TRG}"
	elif [ -e "${TOGOID_DIR}/config/${TRG}-${SRC}" ]; then
	    TERM="reverse"
	    F_NAME="${TRG}-${SRC}"
	else
	    continue
	fi
	
	TIO=`grep ${TERM} ${TOGOID_DIR}/config/${F_NAME}/config.yaml | cut -f2 -d":" | sed -e 's/ //g'`
	YAML="${YAML}\n  - tio:${TIO}*:\n    - ${SRC}-${TRG}: ${DS_LABEL[$TRG]}"
    done
    if [[ $YAML != "" ]]; then
	echo "- ${DS_LABEL[$SRC]}:\n  - a: tio:Dataset${YAML}"
    else
	echo "#- ${DS_LABEL[$SRC]}:"
    fi
done
