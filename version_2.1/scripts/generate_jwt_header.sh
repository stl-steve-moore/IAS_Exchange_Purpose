#!/bin/bash

# Main starts here
# This script creates a JWT header file from an input template
# and a JWKS file that contains a Key ID.
# Args:

set -e

header_template="$1"
jwks_file="$2"
algorithm="$3"
output_file="$4"

if [ ! -f "$jwks_file" ] ; then
 echo "scripts/generate_jwt_header.sh: JWKS file does not exist: $jwks_file"
 exit 1
fi

mkdir -p `dirname $output_file`

kid=`jq ".keys[].kid" $jwks_file | sed -e 's/"//g'`

  cat "$header_template" | sed	\
    -e "s/__ALG__/${algorithm}/"	\
    -e "s/KID/${kid}/"			\
  > "$output_file"

