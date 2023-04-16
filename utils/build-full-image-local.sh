#! /bin/bash
set -e
docker pull archlinux:base-devel
docker build --no-cache -t chimera-full-local:latest .
mkdir -p .cache
chmod 777 .cache
docker run -it --rm --entrypoint /workdir/aur-pkgs/build-aur-packages.sh -v $(pwd):/workdir:Z -v $(pwd)/.cache:/home/build/.cache:Z chimera-full-local:latest
docker run -it --rm -u root --privileged=true --entrypoint /workdir/build-image.sh -e LOCAL_BUILD=1 -v $(pwd):/workdir:Z -v $(pwd)/output:/output:z chimera-full-local:latest $(echo local-$(git rev-parse HEAD | cut -c1-7))