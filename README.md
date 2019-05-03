# MCH Remote Command Execution

This script collection is based on `expect` to automate the SSH terminal interaction. All commands and its respective expected outputs are defined on `exp_scripts/` folder.

## Usage

### Communicating with a single MCH

    ./mch-exec-cmd.exp <MCH IP> <MCH Password> <Expect script> [script args]

For example, to reboot all AMCs in this MCH:

    ./mch-exec-cmd.exp <MCH IP> <MCH Password> exp_scripts/reboot-all-amcs.exp


### Communicating with multiple MCHs

The script `mch-exec-cmd-all.sh` executes the same command to multiple MCHs in sequence. The IP Addresses (or hostnames) are defined in the list variable `CRATE`.

    ./mch-exec-cmd-all.sh <MCH Password> <Expect script> [script args]

### Firmware update

The firmware update needs a little extra setup, which includes setting up a local TFTP server. All the needed configs are done by the script.

First of all download the firmware files from your preferred source and copy `mch_fw.bin` file to `firmwares/mch_fw.bin`, then choose which MCHs will be updated by changing the list inside `mch-exec-cmd-all.sh`.

You run update multiple MCHs in sequence by running:

     ./mch-update-fw.sh <MCH Password> <TFTP server address>
