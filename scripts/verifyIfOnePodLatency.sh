#!/bin/bash
echo "Waiting 5min for the end of the experience"
sleep 300 # Wait for 5 minutes
while true; do
    desired_replicas=$(kubectl get deployment latency -o=jsonpath='{.spec.replicas}')
    if [ "$desired_replicas" -ge 2 ]; then
        echo "Experience not yet finished, retrying in 1min"
        sleep 60 # Adjust the interval as needed
    else
        echo "Experience finished"
        break
    fi
done


