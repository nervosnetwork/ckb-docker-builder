FROM centos:7

ENV PATH=/root/.cargo/bin:$PATH

RUN set -eux; \
    yum install -y centos-release-scl; \
    yum install -y git curl make gcc-c++ openssl-devel llvm-toolset-7; \
    yum clean all; \
    rm -rf /var/cache/yum

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUSTUP_VERSION=1.21.1 \
    RUSTUP_SHA256=ad1f8b5199b3b9e231472ed7aa08d2e5d1d539198a15c5b1e53c746aad81d27b \
    RUST_ARCH=x86_64-unknown-linux-gnu

RUN set -eux; \
    url="https://static.rust-lang.org/rustup/archive/${RUSTUP_VERSION}/${RUST_ARCH}/rustup-init"; \
    curl -LO "$url"; \
    echo "${RUSTUP_SHA256} *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init

ENV RUST_VERSION=1.41.0

RUN set -eux; \
    ./rustup-init -y --no-modify-path --default-toolchain $RUST_VERSION; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;
