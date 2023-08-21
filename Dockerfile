FROM amd64/debian:12
ENV  BINNER_VERSION=2.6.0
WORKDIR /app
ADD https://github.com/replaysMike/Binner/releases/download/v${BINNER_VERSION}/Binner_linux-x64-${BINNER_VERSION}.tar.gz /app/
RUN tar zxfp Binner_linux-x64-${BINNER_VERSION}.tar.gz && rm Binner_linux-x64-${BINNER_VERSION}.tar.gz
RUN chmod +x ./Binner.Web ./install-as-service.sh
RUN ./install-as-service.sh

RUN apt-get -y update && apt-get install -y libicu-dev

ENV export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8

ENTRYPOINT [ "./Binner.Web" ]
EXPOSE 8090