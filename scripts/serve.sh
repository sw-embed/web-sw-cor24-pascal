#!/usr/bin/env bash
set -euo pipefail

PORT=9918

exec trunk serve --port "$PORT" "$@"
