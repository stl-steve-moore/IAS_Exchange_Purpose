#!/bin/bash

check_args() {
  echo "Check args" > /dev/null
}

# Main starts here
# Args:
#       Issuer URL (can include path components)
#       [Output file, defaults to openid-files/openid-configuration]

set -e

check_args $*

TEMPLATE=templates/openid-configuration.json

issuer_url=${1}
output_file="openid-files/openid-configuration"

mkdir -p `dirname $output_file`

cat ${TEMPLATE} | sed -e "s=__ISS__=${issuer_url}=" > ${output_file}

