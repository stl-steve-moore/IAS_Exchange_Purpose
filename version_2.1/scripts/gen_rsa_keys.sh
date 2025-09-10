#!/bin/bash

# Generates a private key and companion public key
# and stores them in the "rsa" folder with today's date
# in the file name.

date_string=`date "+%Y%m%d"`

rsa_folder=`dirname $0`/../rsa
mkdir -p $rsa_folder

prefix="$1"
echo $prefix
if [ "$prefix" == "DATE" ] ; then
 prefix="$date_string"
fi

shift
if [ $# -eq 0 ] ; then
 key_length=2048
else
 key_length=$1
fi

private_pem=$rsa_folder/$prefix.private.pem
public_pem=$rsa_folder/$prefix.public.pem

echo openssl genrsa -out $private_pem $key_length
     openssl genrsa -out $private_pem $key_length

echo openssl rsa -in $private_pem -out $public_pem -pubout
     openssl rsa -in $private_pem -out $public_pem -pubout

ls -lt $rsa_folder

