# tldr
k6 run script.js

# prometheus

go install go.k6.io/xk6/cmd/xk6@latest

xk6 build --with github.com/grafana/xk6-output-prometheus-remote@latest --with github.com/grafana/xk6-distributed-tracing@latest

Then run new k6 binary with the following command for using the default configuration (e.g. remote write server url set to http://localhost:9090/api/v1/write):

kubectl port-forward svc/app 9000:80 -n demo

mv k6 xk6

xk6 run -o xk6-prometheus-rw script.js 
