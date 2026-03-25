#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="/opt/MILo-src"
cd "${ROOT_DIR}"

python -m pip install \
  torch==2.7.0 \
  torchvision==0.22.0 \
  torchaudio==2.7.0 \
  --index-url https://download.pytorch.org/whl/cu128

python -m pip install setuptools wheel ninja pybind11
python -m pip install -r requirements.txt
