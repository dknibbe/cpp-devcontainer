FROM debian:stable-slim AS base
LABEL maintainer="Daniel Knibbe"

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y curl git
RUN apt-get install -y clang-13 clang-format-13 gdb
RUN ln -s /usr/bin/clang-13 /usr/bin/clang
RUN ln -s /usr/bin/clang++-13 /usr/bin/clang++
RUN ln -s /usr/bin/clang-format-13 /usr/bin/clang-format
RUN apt-get install -y cmake ninja-build
ENV CC=clang
ENV CXX=clang++
RUN mkdir -p /build
ENV BUILD_DIR=/build

FROM base AS builder
RUN mkdir -p /workdir
WORKDIR /workdir
COPY . .

WORKDIR /build
RUN mkdir -p /install
RUN cmake /workdir -G Ninja -DCMAKE_INSTALL_PREFIX=/install
RUN cmake --build .
RUN ninja install

FROM debian:stable-slim AS production
COPY --from=builder /install/bin /usr/bin
COPY --from=builder /install/lib /usr/lib
