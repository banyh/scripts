#!/bin/bash

add-apt-repository -y ppa:mc3man/trusty-media
apt-get update
apt-get -y dist-upgrade
apt-get -y install ffmpeg
