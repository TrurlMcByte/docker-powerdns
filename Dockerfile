FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends pdns-server pdns-backend-pgsql pdns-backend-lua2 pdns-tools curl ca-certificates \
    && apt-get clean \
    && rm -rf /etc/powerdns/pdns.d/* \
    && curl -s -L https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -o /usr/bin/yq \
    && chmod +x /usr/bin/yq

# base config
ENV PDNSSC_DAEMON=no \
    PDNSSC_SETUID=pdns \
    PDNSSC_SETGID=pdns \
    PDNSSC_CONFIG_DIR=/etc/powerdns \
    PDNSSC_GUARDIAN=yes \
    PDNSSC_LOGLEVEL=4 \
    PDNSSC_MASTER=yes \
    PDNSSC_SOCKET_DIR=/var/run \
    PDNSSC_VERSION_STRING=powerdns

#    PDNSSC_LAUNCH=""

#COPY pdns.conf /etc/powerdns/
COPY init /sbin/

EXPOSE 53/tcp 53/udp 8051/tcp

ENTRYPOINT ["/sbin/init"]
