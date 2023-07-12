import tracing, { Http } from 'k6/x/tracing';
import http from 'k6/http';
import { sleep } from 'k6';
export const options = {
  vus: 10,
  duration: '300s',
  // iterations: 10,
};

export function setup() {
  console.log(`Running xk6-distributed-tracing v${tracing.version}`, tracing);
}

export default function() {
  const http = new Http({
    propagator: "w3c",
  });
  const r = http.get('http://localhost:9000');
  console.log(`trace_id=${r.trace_id}`);
  sleep(1);
}
