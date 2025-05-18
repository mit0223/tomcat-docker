# Tomcat Docker サンプルプロジェクト

Tomcat で Hello World を表示する HTTP サーバーのサンプルプロジェクトです。

## プロジェクト構成

- `src/main/java/com/example/HelloWorldServlet.java`: Hello World を表示するサーブレット
- `src/main/webapp/`: Webコンテンツ
- `Dockerfile`: マルチステージビルドを使用した Docker イメージ構築用ファイル
- `.devcontainer/`: 開発コンテナの設定
- `.github/workflows/`: GitHub Actions ワークフローファイル

## ビルド方法

以下のコマンドでコンテナイメージをビルドできます：

```bash
# デフォルトのバージョン（最新）でビルド
docker build -t tomcat-hello-world .

# 特定のTomcatバージョンを指定してビルド
docker build --build-arg JAVA_VERSION=17 --build-arg TOMCAT_VERSION=10 -t tomcat-hello-world .
# または特定のTomcatバージョンのみ指定
docker build --build-arg TOMCAT_VERSION=10.1 -t tomcat-hello-world .
```

## 実行方法

以下のコマンドでコンテナを実行できます：

```bash
docker run -p 8080:8080 tomcat-hello-world
```

ブラウザで http://localhost:8080 にアクセスすると、Hello World アプリケーションが表示されます。
http://localhost:8080/hello にアクセスすると、サーブレットからの応答が表示されます。

## GitHub Container Registry によるイメージの配布

このプロジェクトでは、GitHub Actions を利用して GitHub Container Registry (GHCR) にコンテナイメージを自動的に公開します。

### イメージのプル方法

公開されたイメージは以下のコマンドでプルできます：

```bash
# 最新バージョンのプル
docker pull ghcr.io/あなたのユーザー名/tomcat-docker:latest

# 特定のタグのプル（GitHub上のブランチ名やタグ名）
docker pull ghcr.io/あなたのユーザー名/tomcat-docker:main
```

### プルしたイメージの実行

```bash
docker run -p 8080:8080 ghcr.io/あなたのユーザー名/tomcat-docker:latest
```

## 開発環境について

このプロジェクトは VS Code の開発コンテナを使用しています。
開発コンテナには docker-in-docker が組み込まれており、コンテナ内でDockerコマンドを実行できます。

実際の開発環境にはJavaやMavenがインストールされておらず、代わりにDockerコンテナビルドを使用して
アプリケーションのビルドと実行を行います。

### 拡張機能

開発コンテナには以下の VS Code 拡張機能が組み込まれています：

- Java Extension Pack
- XML Support
- Docker
- YAML Support
- Spring Boot Extension Pack
- Maven for Java
- Tomcat for Java
