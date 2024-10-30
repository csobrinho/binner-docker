FROM debian:bookworm-slim
ENV BINNER_VERSION=2.6.3
WORKDIR /app

ADD https://github.com/replaysMike/Binner/releases/download/v${BINNER_VERSION}/Binner_linux-arm64-${BINNER_VERSION}.tar.gz /app/

VOLUME [ "/app/data" ]
RUN set -ex; \
    \
    mkdir -p /app/data/db /app/data/files; \
    apt-get -y update; \
    apt-get install --no-install-recommends --no-install-suggests -y \
      ca-certificates \
      libicu72 \
      libssl3 \
      sqlite3; \
    tar xzfp Binner_linux-arm64-${BINNER_VERSION}.tar.gz; \
    rm Binner_linux-arm64-${BINNER_VERSION}.tar.gz; \
    chmod +x ./Binner.Web; \
    rm -rf /tmp/*; \
    rm -f /app/appsettings.json; \
    ln -s data/appsettings.json appsettings.json
COPY appsettings.json /app/data/appsettings.json

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

EXPOSE 8090
ENTRYPOINT [ "./Binner.Web" ]
