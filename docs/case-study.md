Problem: Application images were built in a single stage with build toolchains, dev dependencies and caches baked in, ballooning to 1.2GB and slowing every deploy.

Solution: Rewrote the Dockerfile with a builder stage for compilation and a slim runtime stage that copies only artifacts, added .dockerignore, layer-ordering for cache hits and a non-root runtime user. Trivy scanning added to the build to catch vulnerable base layers.

Architecture:
01 Stage 1 (builder): install toolchain, resolve dependencies, build artifacts
02 Stage 2 (runtime): slim base + copied artifacts + non-root user
03 Trivy image scan gate before push to registry
