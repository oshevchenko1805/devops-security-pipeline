#!/bin/bash

set -e

ENVIRONMENT=$1
IMAGE_TAG=$2

if [ -z "$ENVIRONMENT" ] || [ -z "$IMAGE_TAG" ]; then
    echo "Usage: ./deploy.sh [blue|green] [image_tag]"
    exit 1
fi

echo "Deploying to $ENVIRONMENT environment with tag $IMAGE_TAG..."

# Обновляем image в deployment
kubectl set image deployment/app-$ENVIRONMENT app=oshevchenko1805/devops-security-pipeline:$IMAGE_TAG

# Ждём готовности deployment
kubectl rollout status deployment/app-$ENVIRONMENT

echo "✅ Deployment to $ENVIRONMENT completed successfully"
