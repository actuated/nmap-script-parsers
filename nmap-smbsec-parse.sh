#!/bin/bash
# nmap-smbsec-parse.sh
# 9/14/2016 by Ted R (http://github.com/actuated)
# Script to take an a file NMAP smb-security-mode script results, and parse them to a list of results
varDateCreated="9/14/2016"
varDateLastMod="9/14/2016"

varInFile="notset"
varOutFile="notset"

function fnUsage {
  echo
  echo "./nmap-smbsec-parse.sh [input file] [optional output file]"
  echo
  exit
}

varInFile="$1"
if [ ! -f "$varInFile" ]; then echo; echo "Error: Input file '$varInFile' does not exist."; fnUsage; fi
varOutFile="$2"
if [ -f "$varOutFile" ]; then echo; echo "Error: Output file $varOutFile already exists."; fnUsage; fi
if [ "$varOutFile" = "" ]; then varOutFile="notset"; fi
#varCount=$(cat $varInFile | grep "State: VULNERABLE" | wc -l)

echo
echo "===================[ nmap-smbsec-parse.sh - Ted R (github: actuated) ]==================="
echo
echo "Press enter to parse $varInFile..."
echo

varThisLine=""
varLastHost=""
varStatus=""
while read varThisLine; do
  varCheckForScanReport=$(echo "$varThisLine" | grep "Nmap scan report for")
  if [ "$varCheckForScanReport" != "" ]; then
    varLastHost=$(echo "$varThisLine" | awk '{print $5}')
  fi
  varCheckForVulnState=$(echo "$varThisLine" | grep "message_signing")
  if [ "$varCheckForVulnState" != "" ]; then
    varStatus=$(echo "$varThisLine" | awk '{print $2, $3}')
    if [ "$varOutFile" != "notset" ]; then
      echo -e "$varLastHost \t $varStatus"
      echo -e "$varLastHost \t $varStatus" >> "$varOutFile"
    else
      echo -e "$varLastHost \t $varStatus"
    fi
  fi
done < "$varInFile"

echo
echo "=========================================[ fin ]========================================="
echo
