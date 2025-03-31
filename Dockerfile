FROM alpine:3.21.3

RUN apk --update upgrade && \
  apk add make gcc musl-dev bash jq && \
  rm -rf /var/cache/apk/*

ARG BOB_BUILDER_TAG
ARG BOB_HOME="/bob"
ARG BOB_USERNAME="bob"
ARG BOB_ARTIFACT_PATH="/bob/artifacts"
ARG BOB_PROJECT_PATH="/bob/project"
ENTRYPOINT ["/bob/entrypoint.sh"]

ENV BOB_HOME="$BOB_HOME"
ENV BOB_USERNAME="$BOB_USERNAME"
ENV BOB_ARTIFACT_PATH="$BOB_ARTIFACT_PATH"
ENV BOB_PROJECT_PATH="$BOB_PROJECT_PATH"
ENV BOB_BUILDER_TAG="$BOB_BUILDER_TAG"

WORKDIR "$BOB_PROJECT_PATH"
COPY entrypoint.sh "${BOB_HOME}/"

RUN adduser -D -h "$BOB_HOME" "$BOB_USERNAME" && \
  mkdir -m 0770 -p "$BOB_ARTIFACT_PATH" "$BOB_PROJECT_PATH" && \
  chown -R "$BOB_USERNAME:$BOB_USERNAME" "$BOB_HOME"

USER "$BOB_USERNAME"
