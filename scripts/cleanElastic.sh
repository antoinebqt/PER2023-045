helm uninstall elastic-operator -n elastic-system
kubectl delete -f elastic-stack/elastic-priority-classes.yaml
kubectl delete -f elastic-stack/elasticsearch-cluster.yaml
kubectl delete -f elastic-stack/kibana-instance.yaml
kubectl delete -f elastic-stack/filebeat-kubernetes.yaml
kubectl delete namespace elastic
