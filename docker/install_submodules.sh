#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="/opt/MILo-src"
cd "${ROOT_DIR}"

python -m pip install submodules/diff-gaussian-rasterization_ms --no-build-isolation
python -m pip install submodules/diff-gaussian-rasterization --no-build-isolation
python -m pip install submodules/diff-gaussian-rasterization_gof --no-build-isolation
python -m pip install submodules/simple-knn --no-build-isolation
python -m pip install submodules/fused-ssim --no-build-isolation

pushd submodules/tetra_triangulation
export CMAKE_PREFIX_PATH="$(python -c 'import torch; print(torch.utils.cmake_prefix_path)')"
rm -f CMakeCache.txt
rm -rf CMakeFiles build
cmake .
make -j"${MAX_JOBS}"
python -m pip install -e . --no-build-isolation
popd

pushd submodules/nvdiffrast
python -m pip install . --no-build-isolation
popd
