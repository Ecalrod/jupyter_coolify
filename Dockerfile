FROM python:3.11-slim

# Set working directory
WORKDIR /workspace

# Install system dependencies for compiling packages
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    gfortran \
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
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Jupyter and common data science packages
RUN pip install --no-cache-dir \
    jupyter \
    jupyterlab \
    numpy \
    pandas \
    matplotlib \
    seaborn \
    scikit-learn \
    plotly

# Create a non-root user
RUN useradd -m -u 1000 jupyter && \
    chown -R jupyter:jupyter /workspace

USER jupyter

# Expose Jupyter port
EXPOSE 8888

# Configure Jupyter to allow connections from any IP
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]