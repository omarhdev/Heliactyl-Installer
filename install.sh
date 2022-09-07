#!/bin/bash

set -e

output() {
  echo -e "* ${1}"
}

execute() {

  bash <(curl -s "$1") 
  [[ -n $2 ]] && execute "$2"
}

HELIACTYL="https://cdn.discordapp.com/attachments/852642185916841994/1017124690109681715/entrypoint.sh"

NGINX=""

  options=(
    "Install Heliactyl"
    "Install Nginx Config"
    "Install both [0] and [1]"
  )

  actions=(
    "$HELIACTYL"
    "$NGINX"
    "$HELIACTYL;$NGINX"
  )

  output "What would you like to do?"

  for i in "${!options[@]}"; do
    output "[$i] ${options[$i]}"
  done

  echo -n "* Input 0-$((${#actions[@]} - 1)): "
  read -r action

  [ -z "$action" ] && error "Input is required" && continue

  valid_input=("$(for ((i = 0; i <= ${#actions[@]} - 1; i += 1)); do echo "${i}"; done)")
  [[ ! " ${valid_input[*]} " =~ ${action} ]] && error "Invalid option"
  [[ " ${valid_input[*]} " =~ ${action} ]] && done=true && IFS=";" read -r i1 i2 <<<"${actions[$action]}" && execute "$i1" "$i2"
done