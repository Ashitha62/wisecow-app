#!/bin/bash

CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

while true; do
    # Get CPU usage and round to integer
    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
    CPU_INT=$(printf "%.0f" "$CPU")   # round to nearest integer

    MEM=$(free | awk '/Mem/ {printf("%.0f"), $3/$2*100}')
    DISK=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

    echo "$(date) CPU:${CPU_INT}% MEM:${MEM}% DISK(/):${DISK}%"

    # Threshold alerts
    if [ "$CPU_INT" -gt $CPU_THRESHOLD ]; then
        echo "$(date) ALERT: High CPU usage: ${CPU_INT}%"
    fi
    if [ "$MEM" -gt $MEM_THRESHOLD ]; then
        echo "$(date) ALERT: High Memory usage: ${MEM}%"
    fi
    if [ "$DISK" -gt $DISK_THRESHOLD ]; then
        echo "$(date) ALERT: High Disk usage: ${DISK}%"
    fi

    #  Check if Wisecow pod is running in Minikube
    if ! kubectl get pods -n default | grep -q "wisecow"; then
        echo "$(date) ALERT: Wisecow pod is not running in Minikube"
    else
        echo "$(date) Wisecow pod is running in Minikube"
    fi

    sleep 5
done








