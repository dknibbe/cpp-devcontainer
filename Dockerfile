FROM debian:bookworm-slim AS base
LABEL maintainer="Daniel Knibbe"

# Update packages
RUN apt-get update && \
    apt-get upgrade -y

# LLVM
ENV LLVM_VERSION=15
RUN apt-get install -y wget lsb-release wget software-properties-common gnupg
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" "${LLVM_VERSION}" "all"
RUN ln -s /usr/bin/clang-${LLVM_VERSION} /usr/bin/clang
RUN ln -s /usr/bin/clang-tidy-${LLVM_VERSION} /usr/bin/clang-tidy
RUN ln -s /usr/bin/clang++-${LLVM_VERSION} /usr/bin/clang++
RUN ln -s /usr/bin/clang-format-${LLVM_VERSION} /usr/bin/clang-format
ENV CC=clang
ENV CXX=clang++

# Dev tools
RUN apt-get install -y curl \
    git \
    cmake \
    ninja-build \
    gdb

# vcpkg
RUN apt-get install -y curl zip unzip tar pkg-config
ENV VCPKG_ROOT=/vcpkg
RUN git clone https://github.com/Microsoft/vcpkg.git ${VCPKG_ROOT}
RUN ${VCPKG_ROOT}/bootstrap-vcpkg.sh
ENV PATH="${PATH}:${VCPKG_ROOT}"
ENV VCPKG_FORCE_SYSTEM_BINARIES=1
RUN vcpkg --version

# create build directory
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

