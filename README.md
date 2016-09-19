# nmap-script-parsers
Simple shell scripts for parsing results from Nmap scripts, including `ssl-heartbleed` and `smb-security-mode`.

# nmap-hb-parse.sh
* Reads the terminal output of the `ssl-heartbleed` NSE, looking for vulnerable targets.
* Usage: `./nmap-hb-parse.sh [inputfilename] [optional outputfilename]`
* An output file, if specified, will be a list of IPs that were found to be vulnerable.

# nmap-smbsec-parse.sh
* Reads the terminal output of the `smb-security-mode` NSE, looking for message signing results.
* Usage: `./nmap-smbsec-parse.sh [inputfilename] [optional outputfilename]`
* An output file, if specified, will be a list of all targets with their corresponding message signing results.
