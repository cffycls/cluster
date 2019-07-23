#!/bin/bash
wget -O /tmp/go.tgz "https://dl.google.com/go/go1.12.7.src.tar.gz"
tar -C /usr/local -xzf /tmp/go.tgz  && rm -f /tmp/go.tgz
ln -s /usr/local/go/bin/ /usr/local/bin/

