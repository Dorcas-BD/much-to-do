#!/bin/bash
S3_BUCKET=$1
CLOUDFRONT_ID=$2
echo "Deploying frontend to S3..."
aws s3 sync Client/dist/ s3://$S3_BUCKET --delete
aws s3 cp Client/dist/index.html s3://$S3_BUCKET/index.html \
  --cache-control "no-cache"
echo "Invalidating CloudFront..."
aws cloudfront create-invalidation \
  --distribution-id $CLOUDFRONT_ID \
  --paths "/*"
echo "Frontend deployed!"
