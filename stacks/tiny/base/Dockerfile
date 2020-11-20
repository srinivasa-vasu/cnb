ARG base_os

FROM ubuntu:${base_os}

RUN apt-get update && \
	apt-get install -y git build-essential xz-utils ca-certificates && \
  rm -rf /var/lib/apt/lists/*

#RUN apt-get update \
#    && apt-get install -y --no-install-recommends git build-essential xz-utils ca-certificates \
#    && rm -rf /var/lib/apt/lists/*

COPY ./bin/jq-linux64 /usr/local/bin/jq
COPY ./bin/yj-linux /usr/local/bin/yj
