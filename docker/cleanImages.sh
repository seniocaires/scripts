#!/bin/bash

# Remover imagens sem versão.
docker rmi $(docker images | grep "<none>" | awk "{print $3}")
