FROM nvidia/cuda:12.8.1-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC \
    CUDA_HOME=/usr/local/cuda \
    PATH=/opt/venv/bin:/usr/local/cuda/bin:${PATH} \
    LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH} \
    CPATH=/usr/local/cuda/targets/x86_64-linux/include:${CPATH} \
    NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility,graphics \
    TORCH_CUDA_ARCH_LIST=12.0+PTX \
    FORCE_CUDA=1 \
    MAX_JOBS=8 \
    PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    git \
    libcgal-dev \
    libegl1 \
    libegl1-mesa-dev \
    libgl1 \
    libgl1-mesa-dev \
    libglib2.0-0 \
    libgles2-mesa-dev \
    libglvnd-dev \
    libgmp-dev \
    libgomp1 \
    libmpfr-dev \
    libsm6 \
    libxext6 \
    libxrender1 \
    ninja-build \
    pkg-config \
    pybind11-dev \
    python-is-python3 \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

RUN python -m venv /opt/venv && \
    /opt/venv/bin/python -m pip install --upgrade pip setuptools wheel

WORKDIR /opt/MILo-src

COPY requirements.txt /opt/MILo-src/requirements.txt
COPY docker/install_python_deps.sh /opt/MILo-src/docker/install_python_deps.sh

RUN bash docker/install_python_deps.sh

COPY . /opt/MILo-src
RUN bash docker/install_submodules.sh

COPY docker/entrypoint.sh /usr/local/bin/milo-entrypoint.sh
RUN chmod +x /usr/local/bin/milo-entrypoint.sh

WORKDIR /workspace/MILo
ENTRYPOINT ["/usr/local/bin/milo-entrypoint.sh"]
CMD ["bash"]
