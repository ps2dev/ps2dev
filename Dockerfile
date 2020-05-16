ARG BASE_DOCKER_IMAGE

FROM $BASE_DOCKER_IMAGE

ENV GSKIT=$PS2DEV/gsKit

COPY . /src

RUN apk add build-base git bash
RUN cd /src && ./build-extra.sh

# Second stage of Dockerfile
FROM alpine:latest  

ENV PS2DEV /usr/local/ps2dev
ENV PS2SDK $PS2DEV/ps2sdk
ENV PATH   $PATH:${PS2DEV}/bin:${PS2DEV}/ee/bin:${PS2DEV}/iop/bin:${PS2DEV}/dvp/bin:${PS2SDK}/bin
ENV GSKIT=$PS2DEV/gsKit

COPY --from=0 ${PS2DEV} ${PS2DEV}