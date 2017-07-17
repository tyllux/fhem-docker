FROM debian:jessie

MAINTAINER Tyllux

ENV FHEM_VERSION 5.8
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

# Updates installieren
RUN apt-get update && \
apt-get upgrade -y --force-yes && \
apt-get dist-upgrade -y --force-yes && \
apt-get install -y --force-yes --no-install-recommends apt-utils

# Abhaengigkeiten installieren
RUN apt-get -y --force-yes install \
apt-transport-https \
build-essential \
dfu-programmer \
git \
nano \
perl \
sqlite3 \
samba \
samba cifs-utils \
samba-common-bin \
snmp \
snmpd \
sudo etherwake \
sqlite3 \
telnet \
usbutils \
wget

# Perl-Pakete installieren
RUN apt-get -y --force-yes install \
libavahi-compat-libdnssd-dev \
libalgorithm-merge-perl \
libclass-dbi-mysql-perl \
libclass-isa-perl \
libcommon-sense-perl \
libdatetime-format-strptime-perl \
libdbd-sqlite3-perl \
libdbi-perl \
libdevice-serialport-perl \
libdpkg-perl \
liberror-perl \
libfile-copy-recursive-perl \
libfile-fcntllock-perl \
libio-socket-ip-perl \
libio-socket-ssl-perl \
libjson-perl \
libjson-xs-perl \
libmail-sendmail-perl \
libnet-telnet-perl \
libsoap-lite-perl \
libsocket-perl \
libswitch-perl \
libsys-hostname-long-perl \
libterm-readkey-perl \
libterm-readline-perl-perl \
libtext-diff-perl \
libwww-perl \
libxml-parser-lite-perl \
libxml-simple-perl

# Speedtest für FHEM installieren & Rechte setzen
RUN wget -O /usr/local/bin/speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
RUN sudo chmod +x /usr/local/bin/speedtest-cli

# Timezone einstellen
RUN echo Europe/Berlin > /etc/timezone && dpkg-reconfigure tzdata

# FHEM installieren
RUN wget https://fhem.de/fhem-${FHEM_VERSION}.deb && dpkg -i fhem-${FHEM_VERSION}.deb

# Benutzdefinierter Skin setzen
RUN cd /opt/fhem/www/ && git clone https://github.com/klein0r/fhem-style-haus-automatisierung.git hausautomatisierung-com && chown -R fhem:dialout /opt/fhem/www/hausautomatisierung-com

# FHEM-User löschen
RUN userdel fhem

# Arbeits-Verzeichnis setzen
WORKDIR "/opt/fhem"

# Update-Config kopieren
COPY /data/fhem.cfg.update ./fhem.cfg

# Quellen für Update hinzufügen
COPY data/FHEM/controls.txt ./FHEM/controls.txt

# FHEM updaten (durch Notify in der 'fhem.cfg')
RUN perl fhem.pl fhem.cfg | tee /opt/fhem/log/fhem.log

# Dateien kopieren
COPY /data/fhem.cfg.example ./fhem.cfg
COPY start.sh ./

#Ports freigeben
EXPOSE 8083 7072

# Start-Script ausführen
CMD bash /opt/fhem/start.sh