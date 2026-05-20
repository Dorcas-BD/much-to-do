#!/bin/bash
ECR_REGISTRY=$1
PREVIOUS_TAG=$2
echo "Rolling back to $PREVIOUS_TAG..."
INSTANCE_IDS=$(aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names starttech-backend-asg \
  --query 'AutoScalingGroups[0].Instances[*].InstanceId' \
  --output text)
for INSTANCE_ID in $INSTANCE_IDS; do
  aws ssm send-command \
    --instance-ids "$INSTANCE_ID" \
    --document-name "AWS-RunShellScript" \
    --parameters commands="[
      'docker stop starttech-api || true',
      'docker rm starttech-api || true',
      'docker run -d --name starttech-api -p 8080:8080 $ECR_REGISTRY/starttech-backend:$PREVIOUS_TAG'
    ]" \
    --region us-east-1
done
echo "Rollback complete"
