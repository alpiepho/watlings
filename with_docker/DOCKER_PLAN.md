# Docker Plan for Watlings

## Requirements Analysis

From the README and package.json:

| Requirement | Notes |
|-------------|-------|
| **Node.js 23+** | Required for `--experimental-wasm-exnref` flag (exercises 015+) |
| **wasm-tools CLI** | Must be on PATH; used for compiling WAT to WASM |
| **npm** | For running scripts (`npm start`, `npm run show`, etc.) |

---

## Files Created

All Docker files are located in the `with_docker/` directory:

- `Dockerfile` - Node.js 23 + wasm-tools image
- `docker-compose.yml` - Service configuration (mounts parent directory)
- `.dockerignore` - Excludes node_modules, .git, logs
- `DOCKER_PLAN.md` - This documentation

### Dockerfile

```dockerfile
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
```

### docker-compose.yml

```yaml
version: '3.8'
services:
  watlings:
    build: .
    volumes:
      - ..:/app    # Mount parent directory (watlings root)
    working_dir: /app
    stdin_open: true
    tty: true
```

### .dockerignore

```
node_modules
.git
*.log
```

---

## Usage Workflow

> **Important:** All commands must be run from the `with_docker` subdirectory.
> **Note:** Use `docker compose` (without hyphen) - this is the modern syntax.

### Build the Container

```bash
# Navigate to with_docker directory first
cd /mnt/c/Users/alpiepho/Projects/watlings/with_docker

# Build the image
docker compose build
```

### Run Exercises Interactively

```bash
# Start an interactive bash session
docker compose run --rm watlings bash

# Then inside the container:
npm start 001_hello
npm run show 001_hello
npm run solve 001_hello
```

### Run One-Off Commands

```bash
# Test an exercise
docker compose run --rm watlings npm start 001_hello

# Show solution
docker compose run --rm watlings npm run show 001_hello

# Apply solution
docker compose run --rm watlings npm run solve 001_hello
```

### Using Docker Directly (without compose)

```bash
# From with_docker directory - mount parent as /app
docker run -it --rm -v "$(pwd)/..:/app" -w /app with_docker-watlings bash

# Run a single command
docker run --rm -v "$(pwd)/..:/app" -w /app with_docker-watlings npm start 001_hello
```

---

## Platform-Specific Notes

### Windows (WSL2/Ubuntu)

Since you're running WSL2 with Docker support:

1. **Open WSL2 terminal** (or run commands with `wsl` prefix from Windows)

2. **Navigate to the `with_docker` directory**:
   ```bash
   cd /mnt/c/Users/alpiepho/Projects/watlings/with_docker
   ```

3. **Build the container**:
   ```bash
   docker compose build
   ```

4. **Run exercises**:
   ```bash
   docker compose run --rm watlings npm start 001_hello
   ```

5. **File edits** can still be done in VS Code on Windows - changes will be reflected in the container via the volume mount

**Or from Windows Command Prompt/PowerShell** (prefix with `wsl`):
```cmd
wsl -e bash -c "cd /mnt/c/Users/alpiepho/Projects/watlings/with_docker && docker compose build"
wsl -e bash -c "cd /mnt/c/Users/alpiepho/Projects/watlings/with_docker && docker compose run --rm watlings npm start 001_hello"
```

### macOS

Docker Desktop for Mac works seamlessly:

1. **Install Docker Desktop** from [docker.com](https://www.docker.com/products/docker-desktop/)

2. **Navigate to the `with_docker` directory** in Terminal:
   ```bash
   cd ~/Projects/watlings/with_docker
   ```

3. **Build and run** using the same commands:
   ```bash
   docker compose build
   docker compose run --rm watlings bash
   ```

4. **File edits** can be done in VS Code or any editor - volume mounts work the same way

> **Note:** On Apple Silicon (M1/M2/M3), Docker will automatically use ARM-compatible images. The `node:23-bookworm-slim` image and wasm-tools binaries support both `amd64` and `arm64` architectures.

---

## README Updates (Optional)

Consider adding a Docker section to the main README:

```markdown
### Using Docker

If you prefer using Docker instead of installing Node.js 23+ and wasm-tools locally:

```sh
cd with_docker

# Build the container
docker compose build

# Run exercises interactively
docker compose run --rm watlings bash

# Or run single commands
docker compose run --rm watlings npm start 001_hello
```
```

---

## Verified ✅

Tested on Windows with WSL2/Ubuntu:

```
$ docker compose run --rm watlings npm start 001_hello
wasm-tools 1.244.0 (d4e317f22 2026-01-06)
compiled 1 file

✘ calls log function
  · log was not called
✘ logs 42
  · num is not 42
----------------
Some tests failed!
```

The tests fail as expected (exercise not completed), confirming the Docker environment works correctly.

All Docker files are located in the `with_docker/` directory:

- `Dockerfile` - Node.js 23 + wasm-tools image
- `docker-compose.yml` - Service configuration (mounts parent directory)
- `.dockerignore` - Excludes node_modules, .git, logs
- `DOCKER_PLAN.md` - This documentation
