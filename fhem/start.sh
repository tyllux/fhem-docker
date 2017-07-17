#!/bin/bash

set -e
cd /opt/fhem
port=7072

perl fhem.pl fhem.cfg | tee /opt/fhem/log/fhem.log
