echo "START PORT"

kubectl port-forward svc/kibana-kb-http 15601:5601 -n elastic &
forward_pid=$!

# Function to stop port forwarding
stop_port_forwarding() {
    echo "STOP PORT"
    kill $forward_pid
}

sleep 2

echo "start curl"

output_file="result.csv"
curl --insecure -H "Authorization: Basic $(echo -n "elastic:FPQ8y8b90juV8LaV88KB12k8" | base64)" "https://localhost:15601/api/reporting/jobs/download/lsd0ev700007ac75bc7716dv" -o "$output_file"

echo "stop curl"

sleep 2

stop_port_forwarding
