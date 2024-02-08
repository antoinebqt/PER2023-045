#!/bin/bash
echo "Waiting 5min for the end of the experience"
sleep 300
while true; do
    desired_replicas=$(kubectl get deployment latency -o=jsonpath='{.spec.replicas}')
    if [ "$desired_replicas" -ge 2 ]; then
        echo "Experience finished"
        break
    else
        echo "Experience not yet finished"
        sleep 5  # Adjust the interval as needed
    fi
done