# 🧱 Docker Images by selimppc

Buildable Dockerfiles for common workloads:
- **PHP on Alpine** (8.2 & 8.4)
- **Docker Engine (DinD) with multi-arch builds**
- **x86-only base image**

> File list (at repo root): `Dockerfile-PHP82-alpine`, `Dockerfile-PHP84-alpine`, `Dockerfile-docker-engine-multi-arch`, `Dockerfile_86_arch`. :contentReference[oaicite:0]{index=0}

---

## 📦 Images

### 1) PHP 8.2 (Alpine)
- File: `Dockerfile-PHP82-alpine` :contentReference[oaicite:1]{index=1}  
- Purpose: Lightweight PHP 8.2 base (good for FPM/CLI apps) with Alpine for small footprint.
- Typical uses: Laravel, Symfony, generic PHP CLI.

**Build**

    docker build -f Dockerfile-PHP82-alpine -t selimppc/php:8.2-alpine .

**Run (CLI example)**

    docker run --rm -it selimppc/php:8.2-alpine php -v

** 2) PHP 8.4 (Alpine)** 
File: Dockerfile-PHP84-alpine 
GitHub
Purpose: Latest-gen PHP 8.4 base on Alpine.
Typical uses: Next-gen PHP projects, performance testing.
Build

    docker build -f Dockerfile-PHP84-alpine -t selimppc/php:8.4-alpine .

Run (CLI example)

    docker run --rm -it selimppc/php:8.4-alpine php -v

** 3) Docker Engine (DinD) – Multi-Arch **
File: Dockerfile-docker-engine-multi-arch 
GitHub
Purpose: A Docker-in-Docker base tailored for Buildx multi-arch image builds (e.g., linux/amd64 + linux/arm64).
Typical uses: CI runners, local builders, release pipelines.
Create & use a multi-arch builder

        # One-time setup
        docker buildx create --name multi --use
        docker run --privileged --rm tonistiigi/binfmt --install all
        
        # Build this image for multiple platforms (example)
        docker buildx build \
          --platform linux/amd64,linux/arm64 \
          -f Dockerfile-docker-engine-multi-arch \
          -t selimppc/docker-engine:multi-arch \
          --push .


** 4) x86-only Base **
File: `Dockerfile_86_arch`
Purpose: Force builds for `linux/amd64` (helpful when native host is `ARM64` like Apple Silicon).
Typical uses: Legacy toolchains, native x86 dependencies.
Build: 

        docker buildx build --platform linux/amd64 \
          -f Dockerfile_86_arch \
          -t selimppc/base:x86 \
          --load .


🧪 Build Matrix Tips
* Speed vs Size: Alpine keeps images tiny; some extensions may need apk add before docker-php-ext-install.
* Reproducibility: Pin base images and tools via tags/digests where possible.
* Multi-arch: Use Buildx with --platform to produce both amd64 and arm64 images from the same Dockerfile.

🔐 Security & Production Notes
* Always scan images: docker scout cves selimppc/php:8.4-alpine (or Trivy/Grype).
* Keep base images updated; rebuild regularly.
* Run as non-root where feasible; mount volumes read-only in production.
* Use healthchecks and resource limits in Compose/K8s.


📄 License

MIT — see LICENSE.md. 
GitHub

🙋 Support & Contributions
Issues and PRs are welcome.

