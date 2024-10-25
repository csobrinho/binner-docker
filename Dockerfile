FROM alpine:3.20
ENV BINNER_VERSION=2.6.3
WORKDIR /app

ADD https://github.com/replaysMike/Binner/releases/download/v${BINNER_VERSION}/Binner_linux-arm64-${BINNER_VERSION}.tar.gz /app/

VOLUME [ "/app/data" ]
RUN set -ex; \
    \
    mkdir -p /app/data/db /app/data/files; \
    apk add -U --upgrade --no-cache \
    icu-libs \
    sqlite-libs; \
    tar xzfp Binner_linux-arm64-${BINNER_VERSION}.tar.gz; \
    rm Binner_linux-arm64-${BINNER_VERSION}.tar.gz; \
    chmod +x ./Binner.Web; \
    rm -rf /tmp/*; \
    rm -f /app/appsettings.json; \
    ln -s data/appsettings.json appsettings.json
COPY appsettings.json /app/data/appsettings.json

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8

EXPOSE 8090
ENTRYPOINT [ "./Binner.Web" ]
