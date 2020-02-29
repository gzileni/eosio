FROM ubuntu:18.04

# ----------------------------------------------------
LABEL author="Giuseppe Zileni <giuseppe.zileni@gmail.com>" maintainer="Giuseppe Zileni <giuseppe.zileni@gmail.com>" version="2.0.0" \
  description="This is a base image for building eosio/eos"

# ----------------------------------------------------
RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
  && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo apt-utils wget curl net-tools ca-certificates unzip gnupg2 cmake git openssl libusb-1.0-0 && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/EOSIO/eos/releases/download/v2.0.0/eosio_2.0.0-1-ubuntu-18.04_amd64.deb
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ./eosio_2.0.0-1-ubuntu-18.04_amd64.deb

RUN wget https://github.com/EOSIO/eosio.cdt/releases/download/v1.7.0/eosio.cdt_1.7.0-1-ubuntu-18.04_amd64.deb
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ./eosio.cdt_1.7.0-1-ubuntu-18.04_amd64.deb

WORKDIR /opt/eosio
ENV EOSIO_ROOT=/opt/eosio
COPY ./nodeosd.sh /opt/eosio
RUN chmod +x /opt/eosio/nodeosd.sh

WORKDIR /opt/eosio/data
WORKDIR /opt/eosio/wallet
WORKDIR /opt/eosio/snapshots

VOLUME /opt/eosio/data
VOLUME /opt/eosio/wallet

COPY ./data/config.ini /opt/eosio/data
COPY ./data/genesis.json /opt/eosio/data
