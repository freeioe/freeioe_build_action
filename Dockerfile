# FROM kooiot/freeioe_toolchains:latest as toolchain

# uncompress the toolchain in builder image
# RUN /download_toolchains.sh
# RUN /uncompress_toolchains.sh

FROM kooiot/debian_builder:latest

# COPY --from=toolchain /toolchains /toolchains
# COPY --from=toolchain /download_toolchains.sh /download_toolchains.sh
# COPY --from=toolchain /uncompress_toolchains.sh /uncompress_toolchains.sh


RUN mkdir -p /home/cch/mycode/
RUN git clone https://github.com/srdgame/skynet.git /home/cch/mycode/skynet

RUN sh /download_toolchains.sh
RUN sh /uncompress_toolchains.sh

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY scripts /actions

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

