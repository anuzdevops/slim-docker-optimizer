# slim-docker-optimizer

**Impact: 85% smaller images, faster pulls and cold starts across environments**

### Problem
Application images were built in a single stage with build toolchains, dev dependencies and caches baked in, ballooning to 1.2GB and slowing every deploy.

### Solution
Rewrote Dockerfile with builder stage + slim runtime that copies only artifacts, added .dockerignore, layer-ordering for cache hits and non-root runtime user. Trivy scanning added to build.

### Architecture
- `01 Stage 1 (builder): install toolchain, resolve dependencies, build artifacts`
- `02 Stage 2 (runtime): slim base + copied artifacts + non-root user`
- `03 Trivy image scan gate before push to registry`

### Tech
Docker, Docker Compose, Alpine, Trivy

### Local Run (Docker Desktop + WSL)
```bash
docker build -t slim-app:local .
docker compose up
./scripts/scan.sh slim-app:local
