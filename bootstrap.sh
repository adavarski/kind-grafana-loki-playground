kind create cluster --config kind.yaml
# Pod errors due to “too many open files”
# https://kind.sigs.k8s.io/docs/user/known-issues/#pod-errors-due-to-too-many-open-files
# sudo sysctl fs.inotify.max_user_watches=524288
# sudo sysctl fs.inotify.max_user_instances=512
# make persistent in /etc/sysctl.conf
helm repo add prometheus https://prometheus-community.github.io/helm-charts
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add sloth https://slok.github.io/sloth
helm repo add kubecost https://kubecost.github.io/cost-analyzer
helm repo update

# prometheus
kubectl create namespace prometheus
helm upgrade --install -n prometheus --values prometheus/values.yaml prometheus prometheus/kube-prometheus-stack --version=46.5.0

# loki
kubectl create namespace loki
helm upgrade --install -n loki --values promtail/values.yaml promtail grafana/promtail --version=6.11.1
helm upgrade --install -n loki --values loki/values.yaml loki grafana/loki --version=5.6.0

# tempo
kubectl create namespace tempo
helm upgrade --install -n tempo tempo grafana/tempo --version=1.3.1

# otel
kubectl create namespace otel
helm upgrade --install -n otel --values otel-collector/values.yaml opentelemetry-collector open-telemetry/opentelemetry-collector --version=0.56.0

# Fixes
kubectl delete ds -n loki loki-logs
kubectl delete deployment loki-grafana-agent-operator -n loki
kubectl delete grafanaagents loki -n lokiw

# demo
kubectl create namespace demo
kubectl apply -f demo/deploy.yaml -n demo
kubectl apply -f demo/svc.yaml -n demo
kubectl apply -f demo/svc-monitor.yaml -n demo
kubectl apply -f demo/configmap.yaml -n prometheus

# sloth
kubectl create ns sloth
helm upgrade --install -n sloth sloth sloth/sloth --values sloth/values.yaml --version=0.7.0
kubectl apply -f demo/slo/test.yaml -n prometheus
kubectl apply -f sloth/configmap.yaml -n prometheus

# K6
kubectl apply -f k6/configmap.yaml -n prometheus
# Install K6 on Linux
# https://github.com/grafana/k6/releases/download/v0.44.1/k6-v0.44.1-linux-amd64.deb

# TODO: fix grafana maps

helm upgrade --install kubecost kubecost/cost-analyzer -n kubecost --create-namespace

# nginx ingress (kind)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

sleep 120

kubectl apply -f ingresses/ingres-grafana.yaml

echo "=================================================="
echo "Grafana URL: http://grafana.192.168.1.100.nip.io \n"
echo "=================================================="
echo "Grafana admin password:\n":
echo "--------------------------------------------------"
kubectl get secret --namespace prometheus prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

