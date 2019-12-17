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
    RUSTUP_VERSION=1.19.0 \
    RUSTUP_SHA256=36285482ae5c255f2decfab27d32ba19465804cb3ddf5a23e6ff2a7b0f6e0250 \
    RUST_ARCH=x86_64-unknown-linux-gnu

RUN set -eux; \
    url="https://static.rust-lang.org/rustup/archive/${RUSTUP_VERSION}/${RUST_ARCH}/rustup-init"; \
    curl -LO "$url"; \
    echo "${RUSTUP_SHA256} *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init

ENV RUST_VERSION=1.38.0

RUN set -eux; \
    ./rustup-init -y --no-modify-path --default-toolchain $RUST_VERSION; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;
