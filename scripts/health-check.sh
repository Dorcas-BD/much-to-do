#!/bin/bash
ALB_DNS=$1
echo "Running health check on $ALB_DNS..."
for i in {1..5}; do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://$ALB_DNS/health)
  if [ "$STATUS" = "200" ]; then
    echo "Health check passed!"
    exit 0
  fi
  echo "Attempt $i failed (status: $STATUS), retrying in 10s..."
  sleep 10
done
echo "Health check FAILED"
exit 1
