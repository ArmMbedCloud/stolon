# syntax=docker/dockerfile:1.7
# Stolon binaries for platform/stolon (IzumaNetworks paas tools/stolon-image).
FROM --platform=linux/amd64 golang:1.14-buster AS build
ARG STOLON_VERSION=v0.16.0
WORKDIR /src
COPY go.mod go.sum ./
RUN --mount=type=cache,target=/go/pkg/mod go mod download
COPY . .
RUN --mount=type=cache,target=/go/pkg/mod set -e; LDF="-w -X github.com/sorintlab/stolon/cmd.Version=${STOLON_VERSION}"; \
    GO111MODULE=on go build -ldflags "$LDF" -o /out/stolon-keeper ./cmd/keeper; \
    for c in sentinel proxy; do CGO_ENABLED=0 GO111MODULE=on go build -ldflags "$LDF" -o /out/stolon-$c ./cmd/$c; done; \
    CGO_ENABLED=0 GO111MODULE=on go build -ldflags "$LDF" -o /out/stolonctl ./cmd/stolonctl

FROM --platform=linux/amd64 debian:buster-slim AS runtime
COPY --from=build /out/ /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/stolonctl"]
CMD ["--help"]
