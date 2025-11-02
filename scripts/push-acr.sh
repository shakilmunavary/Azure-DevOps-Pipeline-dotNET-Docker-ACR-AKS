#!/usr/bin/env bash
# Optional helper to build and push image locally to ACR
# Usage: ./scripts/push-acr.sh myregistry.azurecr.io myimage:tag

set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <acrLoginServer> <image:tag>"
  exit 2
fi

ACR="$1"
IMAGE_TAG="$2"

echo "Logging into ACR: $ACR"
az acr login --name "${ACR%%.*}"

echo "Building Docker image"
docker build -t ${ACR}/sampleapi:${IMAGE_TAG} .

echo "Pushing Docker image"
docker push ${ACR}/sampleapi:${IMAGE_TAG}

echo "Done: pushed ${ACR}/sampleapi:${IMAGE_TAG}"