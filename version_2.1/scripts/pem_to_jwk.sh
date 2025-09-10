#!/bin/bash

PYTHON="/opt/python-venv/bin/python3"

export PYTHONPATH=`dirname $0`/../python/src
ls $PYTHONPATH
ls $PYTHONPATH/*

jwks_args=""
if [ "$3" != "" ] ; then
  jwks_args="--jwks $3"
fi

mkdir -p `dirname $0`/../jwk

echo $PYTHON -m jwt_management.jwk --key $1 --jwk $2 $jwks_args
     $PYTHON -m jwt_management.jwk --key $1 --jwk $2 $jwks_args

