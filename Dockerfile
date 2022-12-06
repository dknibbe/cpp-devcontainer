FROM debian:bookworm-slim AS base
LABEL maintainer="Daniel Knibbe"

# Update packages
RUN apt update && \
    apt upgrade -y

# LLVM
RUN apt install -y wget lsb-release wget software-properties-common gnupg
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" "15" "all"
RUN ln -s /usr/bin/clang-15 /usr/bin/clang
RUN ln -s /usr/bin/clang++-15 /usr/bin/clang++
RUN ln -s /usr/bin/clang-format-15 /usr/bin/clang-format
ENV CC=clang
ENV CXX=clang++

# Dev tools
RUN apt install -y curl \
                   git \
                   cmake \
                   ninja-build \
                   gdb

RUN mkdir -p /build

FROM base AS builder
RUN mkdir -p /workdir
WORKDIR /workdir
COPY . .
WORKDIR /build
RUN cmake /workdir -G Ninja
RUN cmake --build .
RUN ctest .
RUN ninja install

FROM debian:bookworm-slim AS production
COPY --from=builder /usr/local /usr

