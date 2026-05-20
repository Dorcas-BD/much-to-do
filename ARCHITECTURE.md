# System Architecture

## Overview
StartTech is a full-stack todo application deployed on AWS.

## Components

### Frontend
- React/TypeScript built with Vite
- Hosted on S3, served via CloudFront CDN
- Deployed via GitHub Actions on every push to feature/full-stack

### Backend
- Go API running in Docker containers
- Deployed on EC2 instances in an Auto Scaling Group
- Sits behind an Application Load Balancer
- Logs sent to CloudWatch log group /starttech/backend

### Database
- MongoDB Atlas (cloud-hosted)
- Free tier cluster on AWS us-east-1

### Cache
- ElastiCache Redis (cache.t3.micro)
- Used for sessions and caching

### Infrastructure
- All AWS resources managed with Terraform
- Remote state stored in S3

## CI/CD Flow
1. Developer pushes code to feature/full-stack
2. GitHub Actions triggers frontend or backend pipeline
3. Frontend: build → S3 sync → CloudFront invalidation
4. Backend: test → Docker build → push to ECR → deploy to EC2 via SSM
