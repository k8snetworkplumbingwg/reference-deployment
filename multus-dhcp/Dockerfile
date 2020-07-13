FROM alpine:3.6
RUN apk add --update \
	curl \
  && curl -SLO https://github.com/containernetworking/plugins/releases/download/v0.8.6/cni-plugins-linux-amd64-v0.8.6.tgz \
  && tar xvfpz cni-plugins-linux-amd64-v0.8.6.tgz

ENTRYPOINT ["./dhcp", "daemon", "-hostprefix", "/host"]
