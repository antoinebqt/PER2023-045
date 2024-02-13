#operator
kubectl delete -f ../kubernetes/prometheus-operator-deployment.yaml
kubectl delete crd alertmanagers.monitoring.coreos.com
kubectl delete crd prometheusagents.monitoring.coreos.com

kubectl delete -f ../kubernetes/prometheus-additional.yaml
kubectl delete -f ../kubernetes/prometheus-rules.yaml
kubectl delete -f ../kubernetes/strimzi-pod-monitor.yaml
kubectl delete -f ../kubernetes/prometheus.yaml
kubectl delete -f ../kubernetes/grafana.yaml
kubectl delete -f ../kubernetes/prometheus-service.yaml