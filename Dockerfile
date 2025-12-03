FROM python:3.11-slim

WORKDIR /workspace

# Install only necessary system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    gfortran \
    python3.11-dev \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    git \
    curl \
    wget \
    pkg-config \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libblas-dev \
    liblapack-dev \
    libhdf5-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir \
    jupyter \
    jupyterlab \
    numpy==1.25.4 \
    pandas \
    matplotlib \
    seaborn \
    scikit-learn \
    plotly \
    opencv-python-headless==4.8.1 \
    mediapipe==0.10.0

# Create non-root user
RUN useradd -m -u 1000 jupyter && chown -R jupyter:jupyter /workspace

USER jupyter

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=", "--NotebookApp.password="]
