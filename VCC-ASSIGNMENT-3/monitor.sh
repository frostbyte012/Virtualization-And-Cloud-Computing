#!/bin/bash
while true; do
    echo "CPU Usage: $(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')%"
    echo "Memory Usage: $(free -m | awk 'NR==2{printf "%.2f%%\n", $3*100/$2 }')"
    sleep 5
done
