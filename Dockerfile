####################################################
# GOLANG BUILDER
####################################################
FROM golang:1.11 as go_builder

COPY . /go/src/github.com/malice-plugins/bitdefender
WORKDIR /go/src/github.com/malice-plugins/bitdefender
RUN go get -u github.com/golang/dep/cmd/dep && dep ensure
RUN go build -ldflags "-s -w -X main.Version=v$(cat VERSION) -X main.BuildTime=$(date -u +%Y%m%d)" -o /bin/avscan

####################################################
# PLUGIN BUILDER
####################################################
FROM ubuntu:bionic
# FROM debian:jessie

LABEL maintainer "https://github.com/blacktop"

LABEL malice.plugin.repository = "https://github.com/malice-plugins/bitdefender.git"
LABEL malice.plugin.category="av"
LABEL malice.plugin.mime="*"
LABEL malice.plugin.docker.engine="*"

# Create a malice user and group first so the IDs get set the same way, even as
# the rest of this may change over time.
RUN groupadd -r malice \
  && useradd --no-log-init -r -g malice malice \
  && mkdir /malware \
  && chown -R malice:malice /malware

ARG BDKEY
ENV BDVERSION 7.7-1

ENV BDURLPART BitDefender_Antivirus_Scanner_for_Unices/Unix/Current/EN_FR_BR_RO/Linux/
ENV BDURL https://download.bitdefender.com/SMB/Workstation_Security_and_Management/${BDURLPART}

RUN buildDeps='ca-certificates wget build-essential' \
  && apt-get update -qq \
  && apt-get install -yq $buildDeps psmisc \
  && set -x \
  && echo "===> Install Bitdefender..." \
  && cd /tmp \
  && wget -q ${BDURL}/BitDefender-Antivirus-Scanner-${BDVERSION}-linux-amd64.deb.run \
  && chmod 755 /tmp/BitDefender-Antivirus-Scanner-${BDVERSION}-linux-amd64.deb.run \
  && sh /tmp/BitDefender-Antivirus-Scanner-${BDVERSION}-linux-amd64.deb.run --check \
  && echo "===> Making installer noninteractive..." \
  && sed -i 's/^more LICENSE$/cat  LICENSE/' BitDefender-Antivirus-Scanner-${BDVERSION}-linux-amd64.deb.run \
  && sed -i 's/^CRCsum=.*$/CRCsum="0000000000"/' BitDefender-Antivirus-Scanner-${BDVERSION}-linux-amd64.deb.run \
  && sed -i 's/^MD5=.*$/MD5="00000000000000000000000000000000"/' BitDefender-Antivirus-Scanner-${BDVERSION}-linux-amd64.deb.run \
  && (echo 'accept'; echo 'n') | sh /tmp/BitDefender-Antivirus-Scanner-${BDVERSION}-linux-amd64.deb.run; \
  if [ "x$BDKEY" != "x" ]; then \
  echo "===> Updating License..."; \
  oldkey='^Key =.*$'; \
  newkey="Key = ${BDKEY}"; \
  sed -i "s|$oldkey|$newkey|g" /opt/BitDefender-scanner/etc/bdscan.conf; \
  cat /opt/BitDefender-scanner/etc/bdscan.conf; \
  fi \
  && echo "===> Clean up unnecessary files..." \
  && apt-get purge -y --auto-remove $buildDeps \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /go /usr/local/go

# Ensure ca-certificates is installed for elasticsearch to use https
RUN apt-get update -qq && apt-get install -yq --no-install-recommends ca-certificates \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Update Bitdefender definitions
RUN mkdir -p /opt/malice && echo "accept" | bdscan --update

# Add EICAR Test Virus File to malware folder
ADD http://www.eicar.org/download/eicar.com.txt /malware/EICAR

COPY --from=go_builder /bin/avscan /bin/avscan

WORKDIR /malware

ENTRYPOINT ["/bin/avscan"]
CMD ["--help"]
