FROM arm64v8/ubuntu

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        build-essential \
        gcc \
        g++ \
        libc6-dev \
        wget \
        git \
        pkg-config \
        libclang-dev \
        clang; \
    rm -rf /var/lib/apt/lists/*

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUSTUP_VERSION=1.26.0 \
    RUSTUP_SHA256=673e336c81c65e6b16dcdede33f4cc9ed0f08bde1dbe7a935f113605292dc800 \
    RUST_ARCH=aarch64-unknown-linux-gnu \
    OPENSSL_VERSION=3.1.3 \
    OPENSSL_SHA256=f0316a2ebd89e7f2352976445458689f80302093788c466692fb2a188b2eacf6

RUN set -eux; \
    url="https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"; \
    wget --no-check-certificate "$url"; \
    echo "${OPENSSL_SHA256} *openssl-${OPENSSL_VERSION}.tar.gz" | sha256sum -c -; \
    tar -xzf "openssl-${OPENSSL_VERSION}.tar.gz"; \
    cd openssl-${OPENSSL_VERSION}; \
    ./config no-shared no-zlib -fPIC -DOPENSSL_NO_SECURE_MEMORY; \
    make; \
    make install; \
    cd ..; \
    rm -rf openssl-${OPENSSL_VERSION} openssl-${OPENSSL_VERSION}.tar.gz


RUN set -eux; \
    url="https://static.rust-lang.org/rustup/archive/${RUSTUP_VERSION}/${RUST_ARCH}/rustup-init"; \
    wget "$url"; \
    echo "${RUSTUP_SHA256} *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init

ENV RUST_VERSION=1.71.1

RUN set -eux; \
    ./rustup-init -y --no-modify-path --default-toolchain $RUST_VERSION; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version; \
    openssl version;

RUN git config --global --add safe.directory /ckb
