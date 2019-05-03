#!/usr/bin/env bash

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"

# Source misc functions
. ${SCRIPTPATH}/misc/functions.sh

# Simple argument checking
if [ $# -lt 1 ]; then
    echo "Usage: ./mch-exec-cmd-all.sh <MCH Password> <Expect script> [script args]"
    exit 1
fi

# MCH config arguments
MCH_PASS="$1"
EXP_SCRIPT="$2"
shift 2
EXP_SCRIPT_ARGS="$@"

CRATES=()
CRATES+=("10.2.128.33")
#CRATES+=("IA-01RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-02RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-03RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-04RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-05RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-06RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-07RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-08RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-09RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-10RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-11RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-12RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-13RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-14RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-15RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-16RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-17RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-18RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-19RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-20RaBPM-CO-CrateCtrl.lnls-sirius.com.br")
#CRATES+=("IA-20RaBPMTL-CO-CrateCtrl.lnls-sirius.com.br")

for crate in "${CRATES[@]}"; do
    exec_cmd "INFO " echo "Executing script $(basename $EXP_SCRIPT) on $crate"
    ${SCRIPTPATH}/mch-exec-cmd.exp $crate $MCH_PASS $EXP_SCRIPT $EXP_SCRIPT_ARGS
done
