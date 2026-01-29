#!/bin/bash

set -e

TARGET=$1

if [ -z "$TARGET" ]; then
    echo "Usage: ./switch-traffic.sh [blue|green]"
    exit 1
fi

echo "Switching traffic to $TARGET environment..."

# Получаем текущий target
CURRENT=$(kubectl get service app-service -o jsonpath='{.spec.selector.version}')

echo "Current traffic target: $CURRENT"
echo "New traffic target: $TARGET"

# Обновляем selector в service
kubectl patch service app-service -p "{\"spec\":{\"selector\":{\"version\":\"$TARGET\"}}}"

echo "✅ Traffic switched to $TARGET"

# Проверяем service
kubectl get service app-service
