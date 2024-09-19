FROM centos:7

ENV PATH=/root/.cargo/bin:$PATH

RUN set -eux; \
    sed -i 's/mirror.centos.org/vault.centos.org/g' /etc/yum.repos.d/CentOS-*.repo; \
    sed -i 's/^#.*baseurl=http/baseurl=http/g' /etc/yum.repos.d/CentOS-*.repo; \
    sed -i 's/^mirrorlist=http/#mirrorlist=http/g' /etc/yum.repos.d/CentOS-*.repo; \
    yum install -y centos-release-scl; \
    yum install -y git curl make devtoolset-8 llvm-toolset-7 perl-core pcre-devel wget zlib-devel; \
    yum clean all; \
    rm -rf /var/cache/yum

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUSTUP_VERSION=1.26.0 \
    RUSTUP_SHA256=0b2f6c8f85a3d02fde2efc0ced4657869d73fccfce59defb4e8d29233116e6db \
    RUST_ARCH=x86_64-unknown-linux-gnu

RUN set -eux; \
    url="https://static.rust-lang.org/rustup/archive/${RUSTUP_VERSION}/${RUST_ARCH}/rustup-init"; \
    curl -LO "$url"; \
    echo "${RUSTUP_SHA256} *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init

ENV RUST_VERSION=1.75.0

RUN set -eux; \
    ./rustup-init -y --no-modify-path --default-toolchain $RUST_VERSION; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;

RUN git config --global --add safe.directory /ckb
RUN git config --global --add safe.directory /ckb-cli

COPY centos-7/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
