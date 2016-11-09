#!/bin/bash

PATHSASS=$1
PATHCSS=$2

export GEM_PATH=/usr/local/rvm/gems/ruby-2.3.0
sass --update --sourcemap=none --style compressed $PATHSASS:$PATHCSS
