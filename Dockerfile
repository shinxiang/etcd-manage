FROM golang:1.22-alpine3.18 as builder

WORKDIR /build
COPY . .

RUN set -ex \
    go env -w GO111MODULE=on \
    && go env -w GOPROXY=https://goproxy.cn,direct \
    && go env -w CGO_ENABLED=0 \
    && go build -ldflags="-s -w" -o /build/etcd-manage main.go

FROM alpine:latest

# 解决go 时区和https请求证书错误问题
RUN  apk --no-cache update \
  && apk --no-cache add tzdata \
  && apk --no-cache add ca-certificates \
  && update-ca-certificates

COPY --from=builder /build/etcd-manage /app/
COPY --from=builder /build/bin /app/

WORKDIR /app
EXPOSE 10280
CMD ["./etcd-manage"]
