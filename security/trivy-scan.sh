#!/bin/bash
IMAGE_NAME="$1"
SEVERITY="HIGH,CRITICAL"
echo ">>> Scanning: $IMAGE_NAME"
trivy image --exit-code 1 --severity $SEVERITY --ignore-unfixed --format table "$IMAGE_NAME"
if [ $? -ne 0 ]; then
  echo "SCAN FAILED: HIGH/CRITICAL CVEs found. Blocking push."
  exit 1
fi
echo "Scan passed."
