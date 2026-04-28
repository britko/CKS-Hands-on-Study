#!/usr/bin/env bash
set -euo pipefail

required=(kubectl kind helm)
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

if [[ "${KIND_EXPERIMENTAL_PROVIDER:-}" == "podman" ]]; then
  if command -v podman >/dev/null 2>&1 && podman version >/dev/null 2>&1; then
    echo "[OK] container runtime: podman"
  else
    echo "KIND_EXPERIMENTAL_PROVIDER is set to podman, but Podman is not usable." >&2
    exit 1
  fi
elif command -v docker >/dev/null 2>&1 && docker version >/dev/null 2>&1; then
  echo "[OK] container runtime: docker"
elif command -v podman >/dev/null 2>&1 && podman version >/dev/null 2>&1; then
  echo "[OK] container runtime: podman"
else
  echo "Neither Docker nor Podman is available. See docs/setup/linux.md or docs/setup/macos.md." >&2
  exit 1
fi

echo "All required tools are available."
