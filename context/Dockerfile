FROM busybox:latest as build
ARG SIZE_MB=10

WORKDIR /data

RUN dd if=/dev/urandom of=./file.dat bs=1M count=${SIZE_MB}

FROM scratch
WORKDIR /data
COPY --from=build /data/file.dat .
