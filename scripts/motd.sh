#!/bin/bash

# Generates the MOTD that's displayed on the Home page

# See /usr/share/cowsay/cows for cow options

MOTD=$(cowsay "$1" | sed 's/</\&lt;/g' | sed 's/>/\&gt;/g' | sed 's/\t/    /g' | sed 's/ /\&nbsp;/g' | sed ':a;N;$!ba;s/\n/<br>/g')
# MOTD=$(cowsay "$1" | sed ':a;N;$!ba;s/\n/<br>/g')
echo "$MOTD"