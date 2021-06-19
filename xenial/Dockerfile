FROM ubuntu:xenial

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends wget software-properties-common apt-transport-https; \
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -; \
    apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-5.0 main"; \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        gcc \
        libc6-dev \
        git \
        pkg-config \
        libclang-5.0-dev clang-5.0; \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-5.0 60; \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-5.0 60; \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-5.0 60; \
    rm -rf /var/lib/apt/lists/*

ENV OPENSSL_VERSION=1.1.1c \
    OPENSSL_SHA256=f6fb3079ad15076154eda9413fed42877d668e7069d9b87396d0804fdb3f4c90

RUN set -eux; \
    url="https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"; \
    wget "$url"; \
    echo "${OPENSSL_SHA256} *openssl-${OPENSSL_VERSION}.tar.gz" | sha256sum -c -; \
    tar -xzf "openssl-${OPENSSL_VERSION}.tar.gz"; \
    cd openssl-${OPENSSL_VERSION}; \
    ./config no-shared no-zlib -fPIC -DOPENSSL_NO_SECURE_MEMORY; \
    make; \
    make install; \
    cd ..; \
    rm -rf openssl-${OPENSSL_VERSION} openssl-${OPENSSL_VERSION}.tar.gz

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUSTUP_VERSION=1.24.2 \
    RUSTUP_SHA256=6d6d0da8940357eeed733368a6a63fc96e8a1ed1e02fa4c4a60b64b6c66b6057 \
    RUST_ARCH=x86_64-unknown-linux-gnu

RUN set -eux; \
    url="https://static.rust-lang.org/rustup/archive/${RUSTUP_VERSION}/${RUST_ARCH}/rustup-init"; \
    wget "$url"; \
    echo "${RUSTUP_SHA256} *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init

ENV RUST_VERSION=1.51.0

RUN set -eux; \
    ./rustup-init -y --no-modify-path --default-toolchain $RUST_VERSION; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version; \
    openssl version;
