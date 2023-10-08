Environment for building [ckb](https://github.com/nervosnetwork/ckb#readme).

## How to Upgrade Rust

- Update rustup and openssl version if needed in [`gen-dockerfiles`].
- Update rust version in [`gen-dockerfiles`].
- Run the script [`gen-dockerfiles`].
- Commit, tag `rust-${RUST_VERSION}` such as `rust-1.71.0-openssl-3.1.3`.

[`gen-dockerfiles`]: gen-dockerfiles
