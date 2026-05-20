#!/bin/bash
ECR_REGISTRY=$1
IMAGE_TAG=$2
echo "Deploying backend $IMAGE_TAG..."
INSTANCE_IDS=$(aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names starttech-backend-asg \
  --query 'AutoScalingGroups[0].Instances[*].InstanceId' \
  --output text)
for INSTANCE_ID in $INSTANCE_IDS; do
  echo "Updating instance $INSTANCE_ID..."
  aws ssm send-command \
    --instance-ids "$INSTANCE_ID" \
    --document-name "AWS-RunShellScript" \
    --parameters commands="[
      'docker pull $ECR_REGISTRY/starttech-backend:$IMAGE_TAG',
      'docker stop starttech-api || true',
      'docker rm starttech-api || true',
      'docker run -d --name starttech-api -p 8080:8080 $ECR_REGISTRY/starttech-backend:$IMAGE_TAG'
    ]" \
    --region us-east-1
  sleep 20
done
echo "Backend deployed!"
