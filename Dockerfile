FROM kooiot/freeioe_toolchains:latest as toolchain

RUN /download_toolchains.sh
RUN /uncompress_toolchains.sh

FROM kooiot/debian_builder:latest AS build

COPY --from=toolchain /toolchains /toolchains

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY scripts /actions

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

