# Use a user-defined base image
ARG BASE_DOCKER_IMAGE:latest

# First build stage
FROM $BASE_DOCKER_IMAGE AS build

WORKDIR /src

# Copy only necessary files to avoid unnecessary file system changes
COPY . .

# Install required packages in a single step to minimize the number of layers
RUN apk add --no-cache build-base git bash patch wget zlib-dev ucl-dev cmake curl && \
    ./build-extra.sh

# Second stage for a slim final image
FROM alpine:latest

# Install only essential packages
RUN apk add --no-cache make gcc

# Set environment variables
ENV PS2DEV /usr/local/ps2dev
ENV PS2SDK $PS2DEV/ps2sdk
ENV GSKIT $PS2DEV/gsKit
ENV PATH $PATH:${PS2DEV}/bin:${PS2DEV}/ee/bin:${PS2DEV}/iop/bin:${PS2DEV}/dvp/bin:${PS2SDK}/bin

# Copy the compiled PS2 Dev files from the first stage
COPY --from=build ${PS2DEV} ${PS2DEV}

WORKDIR /workspace  # Set a default working directory
