#!/bin/bash

# Arguments:
#             Key file
#             JWT header file
#             JWT payload file
#             Output signed payload
#             Output (full) JWT


KEY_FILE="$1"
JWT_HEADER="$2"
JWT_PAYLOAD="$3"
SIGNATURE="$4"
OUTPUT_FILE="$5"

# Assume running on Linux and check for Mac
BASE64_FLAGS="-w 0"
unameOut=`uname -s`
if [ "$unameOut" == "Darwin" ] ; then
  BASE64_FLAGS=""
fi

mkdir -p `dirname $OUTPUT_FILE`

echo openssl dgst -sha256 -sign  $KEY_FILE  -out  $SIGNATURE   $JWT_PAYLOAD
     openssl dgst -sha256 -sign "$KEY_FILE" -out "$SIGNATURE" "$JWT_PAYLOAD"

   header=`base64 $BASE64_FLAGS -i $JWT_HEADER`
     body=`base64 $BASE64_FLAGS -i $JWT_PAYLOAD`
signature=`base64 $BASE64_FLAGS -i $SIGNATURE`
period="."

echo $header$period$body$period$signature > $OUTPUT_FILE

