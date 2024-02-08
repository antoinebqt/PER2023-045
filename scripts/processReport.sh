# Sleep for 10 minutes
#sleep 600

# Start port forwarding
kubectl port-forward svc/kibana-kb-http 15601:5601 -n elastic &
forward_pid=$!

# Function to stop port forwarding
stop_port_forwarding() {
    kill $forward_pid
}

# Start and get report
ELASTIC_PASSWORD=$(kubectl get secret elastic-cluster-es-elastic-user -o go-template='{{.data.elastic | base64decode}}' -n elastic)
echo "Get password : $ELASTIC_PASSWORD"

# Execute POST request for start the report on the last 10 minutes
echo "Request reporting"
response_post=$(curl --insecure --request POST -H "Authorization: Basic $(echo -n "elastic:FPQ8y8b90juV8LaV88KB12k8" | base64)" "https://localhost:15601/api/reporting/generate/csv_searchsource?jobParams=%28browserTimezone%3AEurope%2FParis%2Ccolumns%3A%21%28%27%40timestamp%27%2Cmessage%2Ckubernetes.pod.name%29%2CobjectType%3Asearch%2CsearchSource%3A%28fields%3A%21%28%28field%3A%27%40timestamp%27%2Cinclude_unmapped%3Atrue%29%2C%28field%3Amessage%2Cinclude_unmapped%3Atrue%29%2C%28field%3Akubernetes.pod.name%2Cinclude_unmapped%3Atrue%29%29%2Cfilter%3A%21%28%28meta%3A%28field%3A%27%40timestamp%27%2Cindex%3A%2729d8fc69-d1b1-49b9-afcd-a79dba01515e%27%2Cparams%3A%28%29%29%2Cquery%3A%28range%3A%28%27%40timestamp%27%3A%28format%3Astrict_date_optional_time%2Cgte%3Anow-10m%2Clte%3Anow%29%29%29%29%29%2Cindex%3A%2729d8fc69-d1b1-49b9-afcd-a79dba01515e%27%2Cparent%3A%28filter%3A%21%28%28%27%24state%27%3A%28store%3AappState%29%2Cmeta%3A%28alias%3A%21n%2Cdisabled%3A%21f%2Cindex%3A%2729d8fc69-d1b1-49b9-afcd-a79dba01515e%27%2Ckey%3Akubernetes.deployment.name%2Cnegate%3A%21f%2Cparams%3A%28query%3Alatency%29%2Ctype%3Aphrase%29%2Cquery%3A%28match_phrase%3A%28kubernetes.deployment.name%3Alatency%29%29%29%2C%28%27%24state%27%3A%28store%3AappState%29%2Cmeta%3A%28alias%3A%21n%2Cdisabled%3A%21f%2Cindex%3A%2729d8fc69-d1b1-49b9-afcd-a79dba01515e%27%2Ckey%3Amessage%2Cnegate%3A%21f%2Cparams%3A%28query%3A%27%2Alatency%20is%2A%27%29%2Ctype%3Aphrase%29%2Cquery%3A%28match_phrase%3A%28message%3A%27%2Alatency%20is%2A%27%29%29%29%29%2Cindex%3A%2729d8fc69-d1b1-49b9-afcd-a79dba01515e%27%2Cquery%3A%28language%3Akuery%2Cquery%3A%27%27%29%29%2Csort%3A%21%28%28%27%40timestamp%27%3Adesc%29%29%2CtrackTotalHits%3A%21t%29%2Ctitle%3A%27Latency%20logs%27%2Cversion%3A%278.6.2%27%29")

echo "Post response : $reponse_post"

# Extract the path from the response
url=$(echo "$response_post" | jq -r '.path')
echo "Path to get report : $url"

output_file="python/output/result.csv"

# Loop until the response is different from "wait"
while true; do
    # Execute GET request to get the report
    curl --insecure -H "Authorization: Basic $(echo -n "elastic:FPQ8y8b90juV8LaV88KB12k8" | base64)" "https://localhost:15601$url" -o "$output_file"
    
    # Verify if the response is different from "processing"
    if grep -q -v "processing" "$output_file"; then
        echo "Réponse obtenue et enregistrée dans $output_file"
        break
    else
	    echo "Still process : $(cat $output_file)"
    fi
    
    # Sleep for 2 seconds
    sleep 2
done

# Stop port forwarding
stop_port_forwarding
