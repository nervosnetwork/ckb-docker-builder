Environment for building [ckb](https://github.com/nervosnetwork/ckb#readme).

## How to Upgrade Rust

- Update rustup version if needed in [`gen-dockerfiles`].
- Update rust version in [`gen-dockerfiles`].
- Run the script [`gen-dockerfiles`].
- Commit and tag `rust-${RUST_VERSION}` such as `rust-1.38.0`.

[`gen-dockerfiles`]: gen-dockerfiles
