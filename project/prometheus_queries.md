## Availability SLI
### The percentage of successful requests over the last 5m
```sum(rate(flask_http_request_total{status!~"5.."}[5m])) /sum(rate(flask_http_request_total[5m]))```

## Latency SLI
### 90% of requests finish in these times
``` histogram_quantile(0.90, sum(rate(flask_http_request_duration_seconds_bucket[5m])) by (le, verb))```

## Throughput
### Successful requests per second
```sum(rate(flask_http_request_total{status=~"200"}[5m]))```

## Error Budget - Remaining Error Budget
### The error budget is 20%
```1 - ((1 - (sum(increase(flask_http_request_total{status="200"}[7d])) by (verb)) / sum(increase(flask_http_request_total[7d])) by (verb)) / (1 - .80))```


# Dashboard screenshot for above queries
<img width="1750" alt="Screenshot 2021-12-28 at 8 29 55 PM" src="https://user-images.githubusercontent.com/35258154/147852552-5c43393e-da68-48af-8f36-fd7854ff5d2b.png">
