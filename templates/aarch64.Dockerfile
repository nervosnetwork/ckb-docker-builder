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
    RUSTUP_VERSION=%%RUSTUP_VERSION%% \
    RUSTUP_SHA256=%%RUSTUP_SHA256%% \
    RUST_ARCH=%%RUST_ARCH%% \
    OPENSSL_VERSION=%%OPENSSL_VERSION%% \
    OPENSSL_SHA256=%%OPENSSL_SHA256%%

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

ENV RUST_VERSION=%%RUST_VERSION%%

RUN set -eux; \
    ./rustup-init -y --no-modify-path --default-toolchain $RUST_VERSION; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version; \
    openssl version;

RUN git config --global --add safe.directory /ckb
