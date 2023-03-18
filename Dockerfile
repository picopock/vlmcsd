FROM alpine:latest as builder
WORKDIR /root
COPY . .
RUN apk add --no-cache git make build-base && make

FROM alpine:latest
WORKDIR /root/

COPY --from=builder /root/bin/vlmcsd /usr/bin/vlmcsd

EXPOSE 1688/tcp

STOPSIGNAL SIGQUIT

ENTRYPOINT [ "/usr/bin/vlmcsd", "-D", "-d" ]