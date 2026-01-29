#!/bin/bash

set -e

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
    echo "Usage: ./health-check.sh [blue|green]"
    exit 1
fi

echo "Checking health of $ENVIRONMENT environment..."

# Получаем pod
POD_NAME=$(kubectl get pods -l app=devops-app,version=$ENVIRONMENT -o jsonpath='{.items[0].metadata.name}')

if [ -z "$POD_NAME" ]; then
    echo "❌ No pods found for $ENVIRONMENT environment"
    exit 1
fi

# Проверяем health endpoint
kubectl exec $POD_NAME -- curl -s http://localhost:8000/health

echo ""
echo "✅ Health check passed for $ENVIRONMENT"
