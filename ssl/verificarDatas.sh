#!/bin/bash

# Verificar data de criacao e expiracao do certificado
echo | openssl s_client -connect localhost:443 2>/dev/null | openssl x509 -noout -dates
