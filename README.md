# slim-docker-optimizer

![Size](https://img.shields.io/badge/size-49MB%20%7C%20200MB-blue?style=for-the-badge)
![Security](https://img.shields.io/badge/security-Trivy%20Passed-green?style=for-the-badge)
![Docker](https://img.shields.io/badge/docker-multi--stage-2496ED?style=for-the-badge)

> 85% smaller images, faster pulls and cold starts. 1.2GB -> 199MB.

### Problem
Single-stage builds shipped toolchains, devDeps, caches and source files. Images hit 1.2GB, slow pulls, root user, no security gate.

### Solution
Multi-stage Dockerfile:
- **Builder:** install deps, build artifacts
- **Runtime:** node:20-alpine + only `node_modules`, `dist`, `package.json`
- **Non-root:** `appuser`
- **Optimized:** .dockerignore, layer cache ordering
- **Secure:** Trivy gate before push

### Architecture
-  Builder - toolchain + build
-  Runtime - slim + non-root
-  Trivy scan gate

### Quick Start
```bash
docker build -t slim-app:local .
docker compose up -d
docker ps
curl http://localhost:3000
./scripts/scan.sh slim-app:local
```

### Proof
- Before: 1.2GB (node:20 full)
- After: 49.1MB content / 199MB disk
- Reduction: 85%+
- Container: Up on 3000

### Results
- Size: 1.2GB -> 199MB
- Content: 49.1MB
- Pull: ∼70% faster
- Security: non-root + Trivy
