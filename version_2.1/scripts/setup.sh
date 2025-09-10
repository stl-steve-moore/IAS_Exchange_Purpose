#!/bin/bash

./scripts/gen_rsa_keys.sh qhin_1

./scripts/pem_to_jwk.sh  rsa/qhin_1.private.pem jwk/qhin_1.jwk.json

./scripts/pem_to_jwks.sh rsa/qhin_1.private.pem jwk/qhin_1.jwks.json

./scripts/generate_openid-configuration.sh https://accounts.example.com

