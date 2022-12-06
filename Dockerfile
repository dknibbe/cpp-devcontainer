FROM debian:stable-slim AS base
LABEL maintainer="Daniel Knibbe"

RUN apt-get update &&\
    apt-get -y upgrade &&\
    apt update &&\
    apt upgrade -y
# RUN apt-get -y upgrade
RUN apt-get install -y curl wget git
RUN apt-get install -y gdb
RUN apt install -y lsb-release wget software-properties-common gnupg
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" "15" "all"
RUN ln -s /usr/bin/clang-15 /usr/bin/clang
RUN ln -s /usr/bin/clang++-15 /usr/bin/clang++
RUN ln -s /usr/bin/clang-format-15 /usr/bin/clang-format
RUN apt-get install -y cmake ninja-build
ENV CC=clang
ENV CXX=clang++
RUN mkdir -p /build

FROM base AS builder
RUN mkdir -p /workdir
RUN mkdir -p /install
WORKDIR /workdir
COPY . .
WORKDIR /build
RUN cmake /workdir -G Ninja -DCMAKE_INSTALL_PREFIX=/install
RUN cmake --build .
RUN ninja install

FROM debian:stable-slim AS production
COPY --from=builder /install/bin /usr/bin
COPY --from=builder /install/lib /usr/lib
