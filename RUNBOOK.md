# Operations Runbook

## Health Check
curl http://starttech-alb-2045885971.us-east-1.elb.amazonaws.com/health

## View Backend Logs
aws logs tail /starttech/backend --follow --region us-east-1

## Rollback Backend
bash scripts/rollback.sh <ECR_REGISTRY> <PREVIOUS_IMAGE_TAG>

## SSH into EC2
ssh -i ~/.ssh/starttech-key ubuntu@<INSTANCE_IP>

## Scale Up Manually
aws autoscaling set-desired-capacity \
  --auto-scaling-group-name starttech-backend-asg \
  --desired-capacity 3

## Redeploy Frontend
bash scripts/deploy-frontend.sh starttech-frontend-734910191144 E2MCP1MQ2M1XQG

## Common Issues
- 502 Bad Gateway: backend container crashed, check CloudWatch logs
- Slow response: check Redis connection, may need restart
- Build failing: check GitHub Actions logs for errors
