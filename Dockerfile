FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
	&& apt-get install -y --no-install-recommends pdns-server pdns-backend-pgsql pdns-backend-lua2 pdns-tools \
	&& rm -rf /etc/powerdns/pdns.d/* /var/lib/apt/lists/*

COPY pdns.conf /etc/powerdns/
COPY init /sbin/

EXPOSE 53/tcp 53/udp 8081/tcp

ENTRYPOINT ["/sbin/init"]
