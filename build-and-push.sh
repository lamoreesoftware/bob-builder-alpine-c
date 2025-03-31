#!/usr/bin/env bash

repository="docker.io/lamoreesoftware/bob"
platform="linux/amd64,linux/arm64"
buildx_builder="bob-builders"

version="${1:-0.0.0}"
tag="bob-builder-alpine-c-${version}"

op read "op://builder/docker-builder-access-token/password" | \
 docker login -u "$(op read "op://builder/docker-builder-access-token/username")" --password-stdin

docker buildx inspect --name "$buildx_builder" > /dev/null 2>&1 | \
  docker buildx create --name "$buildx_builder" --node local --platform "$platform" > /dev/null 2>&1

docker buildx build --builder "$buildx_builder" --platform "${platform}" \
  --build-arg "BOB_BUILDER_TAG=${tag}" \
  --tag "${repository}:${tag}" --push .
