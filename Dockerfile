## Base
FROM rust:1.76-alpine3.18 AS base
ENV RUSTFLAGS="-C target-feature=-crt-static"
RUN apk --no-cache add gcc musl-dev openssl openssl-dev strace


## Builder
FROM base AS builder
WORKDIR /app
COPY ./ /app
RUN cargo build --release


## Release
FROM alpine:3.18
RUN apk --no-cache add bash openssl
COPY --from=builder /app/target/release/starter .
ENTRYPOINT ["/starter"]
