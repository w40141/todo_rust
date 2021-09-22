# Docker Official の Rust イメージを使います
FROM rust:1.43

# /todo でビルドします
WORKDIR /todo

# ビルドに必要なファイルをイメージにコピーする
COPY Cargo.toml Cargo.toml
COPY ./src ./src
COPY ./templates ./templates

# ビルドする
RUN cargo build --release

# パスの通った場所にインストールする
RUN cargo install --path .

# コンテナ起動時に Web アプリを起動する
CMD ["todo"]
