#!/bin/sh
number=$1
 

case $number in
  ''|*[!0-9]*) 
    echo "Please provide a valid non-negative integer."
    exit 1
    ;;
esac
 
# Обратный отсчет
while [ "$number" -ge 0 ]; do
  echo "$number"
  number=$((number - 1))
done
