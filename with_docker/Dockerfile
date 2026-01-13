# Use Node.js 23 (Debian-based for better compatibility)
FROM node:23-bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Download pre-built wasm-tools binary
RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then \
        WASM_ARCH="x86_64-linux"; \
    elif [ "$ARCH" = "arm64" ]; then \
        WASM_ARCH="aarch64-linux"; \
    else \
        echo "Unsupported architecture: $ARCH" && exit 1; \
    fi && \
    curl -L "https://github.com/bytecodealliance/wasm-tools/releases/download/v1.244.0/wasm-tools-1.244.0-${WASM_ARCH}.tar.gz" | tar -xzf - && \
    mv wasm-tools-1.244.0-${WASM_ARCH}/wasm-tools /usr/local/bin/ && \
    rm -rf wasm-tools-1.244.0-${WASM_ARCH} && \
    chmod +x /usr/local/bin/wasm-tools

# Set working directory
WORKDIR /app

# Default command
CMD ["bash"]
