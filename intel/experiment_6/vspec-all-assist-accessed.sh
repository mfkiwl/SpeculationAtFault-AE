#!/usr/bin/env bash

set -e

contract="vspec-all"

SCRIPT=$(realpath $0)
SCRIPT_DIR=$(dirname $SCRIPT)
TIMEOUT=$(( 24 * 3600 ))

WORK_DIR=$(realpath $SCRIPT_DIR/../../)
echo "HOME=$WORK_DIR"

revizor_src="$WORK_DIR/sca-fuzzer"
instructions="$revizor_src/base.json"
timestamp=$(date '+%y-%m-%d-%H-%M')

results=$SCRIPT_DIR/results
mkdir -p $results

cp $SCRIPT_DIR/assist-accessed.yaml $SCRIPT_DIR/assist-accessed-vspec-all.yaml
echo ""                               >> $SCRIPT_DIR/assist-accessed-vspec-all.yaml
echo "contract_execution_clause:"     >> $SCRIPT_DIR/assist-accessed-vspec-all.yaml
echo "  - vspec-all-memory-assists"    >> $SCRIPT_DIR/assist-accessed-vspec-all.yaml

logfile="$SCRIPT_DIR/results/assist-accessed-dh-$timestamp.log"
echo "[+] Fuzzing ucode-assist (accessed bit) with $contract; Log at $logfile"
python $revizor_src/revizor.py fuzz -s $instructions -c  $SCRIPT_DIR/assist-accessed-vspec-all.yaml -i 100 -n 100000000 --timeout $TIMEOUT  -w $SCRIPT_DIR/results/violations/ &> $logfile