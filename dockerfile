# # Docker Official の Rust イメージを使います
# FROM rust:1.55 AS builder
# 
# # /todo でビルドします
# WORKDIR /todo
# 
# # ビルドに必要なファイルをイメージにコピーする
# COPY Cargo.toml Cargo.toml
# 
# RUN mkdir src/
# RUN echo "fn main(){}" > src/main.rs
# 
# RUN cargo build --release
# 
# COPY ./src ./src
# COPY ./templates ./templates
# 
# RUN rm -f target/release/deps/todo*
# 
# # ビルドする
# RUN cargo build --release
# 
# FROM debian:10.4
# 
# COPY --from=builder /todo/target/release/todo /usr/local/bin/todo
# 
# # コンテナ起動時に Web アプリを起動する
# CMD ["todo"]

FROM rust:1.43 AS builder

WORKDIR /todo
COPY Cargo.toml Cargo.toml
RUN mkdir src
RUN echo "fn main(){}" > src/main.rs
RUN cargo build --release
COPY ./src ./src
COPY ./templates ./templates
RUN rm -f target/release/deps/todo*
RUN cargo build --release

# リリース用イメージには debian を使用します。
FROM debian:10.4

COPY --from=builder /todo/target/release/todo_rust /usr/local/bin/todo_rust
CMD ["todo_rust"]
