desired_replicas=$(kubectl get deployment latency -o=jsonpath='{.spec.replicas}')

if [ "$desired_replicas" -ge 2 ]; then
    echo "false"
else
    echo "true"
fi