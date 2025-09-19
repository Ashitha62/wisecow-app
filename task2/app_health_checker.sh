#!/bin/bash

# Wisecow App Health Checker Script (Task 2)
# Works with ClusterIP + kubectl port-forward (localhost:4499)

APP_URL="http://localhost:4499"
LOG_FILE="task2/app_health_checker.log"

echo "Starting Wisecow App Health Checker..."
echo "Logs will be saved to $LOG_FILE"
echo "------------------------------------------"

while true; do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL)

    if [ "$STATUS" -eq 200 ]; then
        MSG="$(date) Wisecow APP is UP (Status: $STATUS)"
    else
        MSG="$(date) ALERT: Wisecow APP is DOWN (Status: $STATUS)"
    fi

    echo "$MSG"
    echo "$MSG" >> "$LOG_FILE"

    sleep 5
done

