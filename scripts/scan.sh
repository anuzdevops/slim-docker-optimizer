#!/bin/bash
set -e
IMAGE=${1:-slim-app:local}
echo "🔍 Scanning $IMAGE with Trivy..."
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image --severity HIGH,CRITICAL --exit-code 1 $IMAGE
echo "✅ Gate passed - No HIGH/CRITICAL vulns"
