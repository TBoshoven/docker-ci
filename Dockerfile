FROM alpine:3.12 AS github-release-build

RUN apk add git go
RUN go get github.com/github-release/github-release


FROM alpine:3.12

# Installed applications:
# curl
# git
# github-release
# sed (GNU version instead of busybox version)
RUN apk add curl jq sed
COPY --from=github-release-build /root/go/bin/github-release /usr/local/bin/github-release

RUN adduser --disabled-password ci
USER ci
WORKDIR /home/ci
