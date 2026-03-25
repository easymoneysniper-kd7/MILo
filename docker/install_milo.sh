#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="/opt/MILo-src"
cd "${ROOT_DIR}"

bash docker/install_python_deps.sh
bash docker/install_submodules.sh
