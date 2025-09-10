#!/bin/bash

washington() {
  mkdir -p jwt_files/washington
  JWT_HEADER=jwt_files/washington/jwt_header.json
  JWT_PAYLOAD=jwt_files/washington/jwt_payload.json
  SIGNATURE=jwt_files/washington/jwt_payload.signature
  TOKEN=jwt_files/washington/washington.jwt

  ./scripts/generate_jwt_header.sh	\
      templates/jwt_header.json jwk/qhin_1.jwks.json ${ALGORITHM}	\
      ${JWT_HEADER}


  cat data/washington.txt data/common.txt > /tmp/payload_parameters.$$.txt
  ./scripts/generate_jwt_payload.sh	\
      templates/George_Washington.jwt.json /tmp/payload_parameters.$$.txt \
      ${JWT_PAYLOAD}
# rm -f /tmp/payload_parameters.$$.txt

  ./scripts/sign_jwt.sh	\
      $KEY_FILE         \
      ${JWT_HEADER}     \
      ${JWT_PAYLOAD}    \
      ${SIGNATURE}      \
      ${TOKEN}

  echo "Signed token for Washington: ${TOKEN}"
}

ALGORITHM=RS256
KEY_FILE=rsa/qhin_1.private.pem

 washington
