#!/bin/bash

# Remover volumes órfãos
docker volume rm $(docker volume ls -qf dangling=true)
