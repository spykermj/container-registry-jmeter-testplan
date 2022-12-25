FROM docker.io/busybox:latest as build
ARG SIZE_MB=10

WORKDIR /data

RUN dd if=/dev/urandom of=/data/file.dat bs=1M count=${SIZE_MB}

FROM scratch
COPY --from=build /data/file.dat /data/file.dat
