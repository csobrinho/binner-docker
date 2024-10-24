FROM --platform=linux/arm64 debian:bookworm-slim
ENV BINNER_VERSION=2.6.3
WORKDIR /app
ADD https://github.com/replaysMike/Binner/releases/download/v${BINNER_VERSION}/Binner_linux-arm64-${BINNER_VERSION}.tar.gz /app/
RUN tar zxfp Binner_linux-arm64-${BINNER_VERSION}.tar.gz && rm Binner_linux-arm64-${BINNER_VERSION}.tar.gz
RUN chmod +x ./Binner.Web ./install-as-service.sh
RUN ./install-as-service.sh

RUN apt-get -y update && apt-get install -y libicu-dev

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8

EXPOSE 8090
ENTRYPOINT [ "/app/Binner.Web" ]
