# StartTech Application

Full-stack todo application with React frontend and Go backend.

## Architecture
- Frontend: React/TypeScript → S3 + CloudFront
- Backend: Go API → EC2 Auto Scaling Group behind ALB
- Cache: ElastiCache Redis
- Database: MongoDB Atlas

## CI/CD
- Frontend pipeline: builds and deploys to S3, invalidates CloudFront
- Backend pipeline: builds Docker image, pushes to ECR, deploys to EC2 via SSM

## Environment Variables
See `Server/MuchToDo/.env.example` for required variables.
