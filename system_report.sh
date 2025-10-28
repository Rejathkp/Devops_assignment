#!/usr/bin/env bash

# system_report.sh
# Usage: ./system_report.sh
set -e

DATE=$(date +"%Y-%m-%d %H:%M:%S")
SHORT_DATE=$(date +"%Y-%m-%d")
OUTFILE="/tmp/system_report_${SHORT_DATE}.log"

{
  echo "System Report - ${DATE}"
  echo "----------------------------------"

  # Uptime in pretty format
  # Linux: use `uptime -p` if available
  if command -v uptime >/dev/null 2>&1; then
    echo -n "Uptime: "
    uptime -p || uptime
  else
    echo "Uptime: (command uptime not available)"
  fi

  # Disk usage of the root filesystem as percentage
  DISK_USAGE=$(df -h / | awk 'NR==2 {print $5 " (" $3 " used of " $2 ")"}')
  echo "Disk Usage: ${DISK_USAGE}"

  # Memory usage: used/total and percentage
  if command -v free >/dev/null 2>&1; then
    read -r total used free shared buffcache available <<< $(free -m | awk 'NR==2 {print $2, $3, $4, $5, $6, $7}')
    mem_percent=$(( used * 100 / total ))
    echo "Memory Usage: ${used}MB/${total}MB (${mem_percent}%)"
  else
    echo "Memory Usage: (command free not available)"
  fi

  echo ""
} >> "${OUTFILE}"
