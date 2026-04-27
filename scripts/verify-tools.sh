#!/usr/bin/env bash
set -euo pipefail

required=(docker kubectl kind helm)
optional=(cilium hubble trivy cosign)

for command in "${required[@]}"; do
  if ! command -v "$command" >/dev/null 2>&1; then
    echo "Required command '$command' was not found. See docs/setup/linux.md or docs/setup/macos.md." >&2
    exit 1
  fi
  echo "[OK] $command"
done

for command in "${optional[@]}"; do
  if command -v "$command" >/dev/null 2>&1; then
    echo "[OK] optional: $command"
  else
    echo "[SKIP] optional command not found: $command"
  fi
done

docker version >/dev/null
echo "All required tools are available."
