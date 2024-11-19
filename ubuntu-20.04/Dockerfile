FROM ubuntu:20.04

ENV PATH=/root/.cargo/bin:$PATH

RUN set -eux; \
    apt update; \
    apt install -y git curl build-essential llvm perl libpcre3-dev wget zlib1g-dev; \
    apt clean all; \
    rm -rf /var/cache/apt

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUSTUP_VERSION=1.27.1 \
    RUSTUP_SHA256=6aeece6993e902708983b209d04c0d1dbb14ebb405ddb87def578d41f920f56d \
    RUST_ARCH=x86_64-unknown-linux-gnu

RUN set -eux; \
    url="https://static.rust-lang.org/rustup/archive/${RUSTUP_VERSION}/${RUST_ARCH}/rustup-init"; \
    curl -LO "$url"; \
    echo "${RUSTUP_SHA256} *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init

ENV RUST_VERSION=1.81.0

RUN set -eux; \
    ./rustup-init -y --no-modify-path --default-toolchain $RUST_VERSION; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;

RUN git config --global --add safe.directory /ckb
RUN git config --global --add safe.directory /ckb-cli

CMD ["bash"]
