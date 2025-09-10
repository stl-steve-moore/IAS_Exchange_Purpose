#!/bin/bash

PYTHON="/opt/python-venv/bin/python3"

export PYTHONPATH=`dirname $0`/../python/src
ls $PYTHONPATH
ls $PYTHONPATH/*

mkdir -p `dirname $0`/../jwk

echo $PYTHON -m jwt_management.jwk --key $1 --jwks $2
     $PYTHON -m jwt_management.jwk --key $1 --jwks $2

