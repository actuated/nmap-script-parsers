#!/bin/bash
# nmap-hb-parse.sh
# 3/9/2016 by Ted R (http://github.com/actuated)
# Script to take an a file NMAP Heartbleed script results, and parse them for a list of vulnerable hosts
varDateCreated="3/9/2016"
varDateLastMod="3/9/2016"

varInFile="notset"
varOutFile="notset"

function fnUsage {
  echo
  echo "./nmap-hb-parse.sh [input file] [optional output file]"
  echo
  exit
}

varInFile="$1"
if [ ! -f "$varInFile" ]; then echo; echo "Error: Input file '$varInFile' does not exist."; fnUsage; fi
varOutFile="$2"
if [ -f "$varOutFile" ]; then echo; echo "Error: Output file $varOutFile already exists."; fnUsage; fi
if [ "$varOutFile" = "" ]; then varOutFile="notset"; fi
varCount=$(cat $varInFile | grep "State: VULNERABLE" | wc -l)

echo
echo "=====================[ nmap-hb-parse.sh - Ted R (github: actuated) ]====================="
echo
echo "Vulnerable hosts from $varInFile ($varCount):"
echo

varThisLine=""
varLastHost=""
while read varThisLine; do
  varCheckForScanReport=$(echo "$varThisLine" | grep "Nmap scan report for")
  if [ "$varCheckForScanReport" != "" ]; then
    varLastHost=$(echo "$varThisLine" | awk '{print $5}')
  fi
  varCheckForVulnState=$(echo "$varThisLine" | grep "State: VULNERABLE")
  if [ "$varCheckForVulnState" != "" ]; then
    if [ "$varOutFile" != "notset" ]; then
      echo "$varLastHost"
      echo "$varLastHost" >> "$varOutFile"
    else
      echo "$varLastHost"
    fi
  fi
done < "$varInFile"

echo
echo "=========================================[ fin ]========================================="
echo
