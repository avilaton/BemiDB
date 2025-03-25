#!/bin/bash

PID=$(ps | grep "/exe/BemiDB sync" | grep -v grep | awk '{print $1}')

if ! ps -p "$PID" > /dev/null 2>&1; then
  echo "Error: Process with PID $PID does not exist"
  exit 1
fi

echo "PID    Time                 Memory (MB)"

while true; do
  current_time=$(date "+%Y-%m-%d %H:%M:%S")

  # Get last line of top output for the process
  memory=$(top -pid $PID -stats mem -l 1 | tail -n 1)
  printf "%s  %s  %s\n" "$PID" "$current_time" "$memory"

  sleep 1
done
