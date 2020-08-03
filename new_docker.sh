#!/bin/bash

read -p "name: " usr

mkdir /home/spresearch/VOLUME/$usr
mkdir /home/spresearch/m2/VOLUME/$usr
mkdir /home/spresearch/sdb/VOLUME/$usr
mkdir /home/spresearch/sdc/VOLUME/$usr
mkdir /home/spresearch/sdd/VOLUME/$usr

chown -R spresearch:spresearch /home/spresearch/VOLUME/$usr
chown -R spresearch:spresearch /home/spresearch/m2/VOLUME/$usr
chown -R spresearch:spresearch /home/spresearch/sdb/VOLUME/$usr
chown -R spresearch:spresearch /home/spresearch/sdc/VOLUME/$usr
chown -R spresearch:spresearch /home/spresearch/sdd/VOLUME/$usr

exit 0