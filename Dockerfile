# マルチステージビルドのDockerfile
# ARGはすべてのFROM命令の前に宣言して、すべてのステージで使用できるようにする
ARG JAVA_VERSION=latest
ARG TOMCAT_VERSION=latest

# ビルドステージはMavenを使用
FROM maven:${JAVA_VERSION} AS build

WORKDIR /app
# ソースコードをコピー
COPY pom.xml .
COPY src ./src

# Mavenでビルド
RUN mvn clean package

# 実行ステージはTomcatの公式イメージを使用
FROM tomcat:${TOMCAT_VERSION}

# デフォルトのwebappsをクリア
RUN rm -rf ${CATALINA_HOME}/webapps/* || true

# ビルドステージからWARファイルをコピー
COPY --from=build /app/target/hello-world.war ${CATALINA_HOME}/webapps/ROOT.war

# 8080ポートを公開
EXPOSE 8080

# Tomcatを起動
CMD ["catalina.sh", "run"]
