kubectl delete deployment strimzi-cluster-operator
kubectl delete deployment latency
kubectl delete deployment my-cluster-entity-operator
kubectl delete deployment my-cluster-kafka-exporter
helm repo remove prometheus-community
helm delete prometheus
kubectl delete svc assignmentservice
kubectl delete svc my-cluster-kafka-bootstrap
kubectl delete svc my-cluster-kafka-brokers
kubectl delete svc my-cluster-zookeeper-client
kubectl delete svc my-cluster-zookeeper-nodes
kubectl delete svc rateservice
kubectl delete pod controllerandscaler
kubectl delete pod my-cluster-kafka-0
kubectl delete pod my-cluster-kafka-1
kubectl delete pod my-cluster-kafka-2
kubectl delete pod my-cluster-zookeeper-0
kubectl delete pod my-cluster-zookeeper-1
kubectl delete pod my-cluster-zookeeper-2
kubectl delete pod workload

./cleanPrometheus.sh
