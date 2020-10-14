FROM kooiot/freeioe_toolchains:latest as toolchain

RUN /download_toolchains.sh
RUN /uncompress_toolchains.sh

FROM debian:buster AS build

COPY --from=toolchain /toolchains /toolchains

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY scripts /actions

RUN apt-get update
RUN apt-get install -y build-essential git autoconf \
    libreadline-dev \
	libssl-dev \
	libcurl4-openssl-dev \
	libenet-dev \
	libmodbus-dev \
	zlib1g-dev \
	wget \
	zip \
	unzip

RUN wget https://github.com/premake/premake-core/releases/download/v5.0.0-alpha15/premake-5.0.0-alpha15-linux.tar.gz -O /premake5.tar.gz

RUN tar -C /usr/bin -xzvf /premake5.tar.gz
RUN chmod +x /usr/bin/premake5

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

