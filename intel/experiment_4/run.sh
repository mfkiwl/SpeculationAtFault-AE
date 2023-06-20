#!/usr/bin/env bash

set -e

contract="delayed-exception-handling"

SCRIPT=$(realpath $0)
SCRIPT_DIR=$(dirname $SCRIPT)
TIMEOUT=$(( 24 * 3600 ))

WORK_DIR=$(realpath $SCRIPT_DIR/../../)
echo "HOME=$WORK_DIR"


instructions="$WORK_DIR/base.json"
timestamp=$(date '+%y-%m-%d-%H-%M')

results=$SCRIPT_DIR/results
mkdir -p $results

logfile="$SCRIPT_DIR/results/BR-dh-$timestamp.log"
echo "[+] Fuzzing #BR (mpx instructions) with $contract; Log at $logfile"
rvzr fuzz -s $instructions -c  $SCRIPT_DIR/BR-dh.yaml -i 100 -n 100000000 --timeout $TIMEOUT  -w $SCRIPT_DIR/results/violations/ &> $logfile