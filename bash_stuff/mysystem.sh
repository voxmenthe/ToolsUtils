#!/bin/bash
clear
echo "This is information provided by mysystem.sh.  Program starts now."

echo "Hello, $USER"
echo

echo "Today's date is `date`, this is week `date +"%V"`."
echo

echo "These users are currently connected:"
w | cut -d " " -f 1 - | grep -v USER | sort -u
echo

echo "This is `uname -s` running on a `uname -m` processor."
echo

echo "This is the uptime information:"
uptime
echo

nvidia-smi

echotop
echo "Top 10 processes:"
echo "PID    USER      PR  NI   VIRT    RES    SHR  S   %CPU  %MEM   TIME+  COMMAND"
top -b -n1 | grep '^ *[0-9]' | head -n 10
echo

echo "That's all folks!"