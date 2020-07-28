#!/usr/bin/env bash

# Prerequisits:
  # nmap


## May update this later to ask for an IP range. For the time being, just doing 192.168.1.0 - 192.168.1.255

[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

active_ips=$(nmap -nsP 192.168.1.0/24 2>/dev/null -oG - | grep "Up$" | awk '{printf "%s ", $2}' )
active_ips=$(echo $active_ips |  sort -t . -k 3,3n -k 4,4n)
printf "%-20s %-20s %-40s %-20s \n" "IP" "Mac Address" "Manufacturer" "Hostname"
for i in $active_ips
do
  # nmap -F $i
  nmap_output=$(nmap -sn $i)
  mac_address=$(echo "$nmap_output" | grep "MAC Address" | awk ' { print $3 }')
  manufacturer=$(echo "$nmap_output" | grep "MAC Address" | cut -d "(" -f2 | cut -d ")" -f1)
  hostname=$(nmap -sn $i | grep "scan report for" | awk ' { print $5 }')
  if [[ "$hostname" == "$i" ]]; then
    hostname=" "
  fi
  printf "%-20s %-20s %-40s %-20s \n" $i $mac_address "$manufacturer" "$hostname"
done
