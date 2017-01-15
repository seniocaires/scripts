#!/bin/bash

# Remover containers não usados.
docker rm $(docker ps -q -f status=exited)
