#!/bin/bash

set -e

NEW_VERSION=$1

if [ -z "$NEW_VERSION" ]; then
    echo "Usage: ./blue-green-deploy.sh [image_tag]"
    exit 1
fi

# Определяем текущее активное окружение
CURRENT=$(kubectl get service app-service -o jsonpath='{.spec.selector.version}' 2>/dev/null || echo "blue")

if [ "$CURRENT" == "blue" ]; then
    TARGET="green"
else
    TARGET="blue"
fi

echo "=== Blue-Green Deployment ==="
echo "Current active: $CURRENT"
echo "Deploy target: $TARGET"
echo "New version: $NEW_VERSION"
echo ""

# 1. Деплой в неактивное окружение
echo "Step 1: Deploying to $TARGET..."
./scripts/deploy.sh $TARGET $NEW_VERSION

# 2. Health check
echo ""
echo "Step 2: Running health checks..."
sleep 10
./scripts/health-check.sh $TARGET

# 3. Переключение трафика
echo ""
echo "Step 3: Switching traffic to $TARGET..."
./scripts/switch-traffic.sh $TARGET

echo ""
echo "=== Deployment completed successfully ==="
echo "Active environment: $TARGET"
echo "Previous environment ($CURRENT) is still running and can be used for rollback"
