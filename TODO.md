## **To Do**

- prometheus should look for servicemonitors and prometheusrules in any namespace
- grafana should look dashboards in any namespace
- use tempo-distributed
- use loki-distributed

## **Bugs**

- ?

## **Issues**

- [Promtail pods need to be restarted to work after a clean installation](https://github.com/grafana/helm-charts/issues/1449)

## **Demo**

- show Loki LogQL
- show Loki Integration w/ Grafana Tempo Button
- step back and talk about how the demo app and how is sending logs and traces
- show Grafana Tempo features
- show Prometheus dashboard for app
- Loading testing with k6 (show dashboard)
- Sloth for error budgets

## **Beyond**

- What can Otel do to enrich logs, metrics and tracing?
- Exemplars? 
- Deployment Markers?
- Blue Green deployment?
- Canary deployment?
- Kubecost

## **Links**

https://vbehar.medium.com/using-prometheus-exemplars-to-jump-from-metrics-to-traces-in-grafana-249e721d4192
https://www.aspecto.io/blog/opentelemetry-collector-guide/
https://blog.container-solutions.com/prometheus-operator-beginners-guide
https://medium.com/experience-valley/spike-fb62eb2a0b1f
