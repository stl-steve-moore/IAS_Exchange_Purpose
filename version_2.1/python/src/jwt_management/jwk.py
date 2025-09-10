#!/bin/python3

import argparse
import json
from jwcrypto import jwk

# See https://jwcrypto.readthedocs.io/en/latest/#

def pem_to_jwk(pem_file_path, password=None):
    """
    Generates a JWK from a PEM-encoded key file.

    Args:
        pem_file_path (str): The path to the PEM file.
        password (str, optional): Password for decrypting the PEM file, if any.

    Returns:
        jwcrypto.jwk.JWK: The JWK object.
    """
    with open(pem_file_path, "rb") as pem_file:
        pem_data = pem_file.read()
    
    try:
        key = jwk.JWK.from_pem(pem_data, password=password)
        return key
    except Exception as e:
        raise ValueError(f"Error converting PEM to JWK: {e}")


def write_jwk(jwk_file:str, jwk_json:str) -> None:
    if jwk_file is None:
        return

    jwk_obj = json.loads(jwk_json)
    with open(jwk_file, "w", encoding="utf-8") as f:
        json.dump(jwk_obj, f, indent=4)
        f.close

# Construct and write JWKS from an input JWK string
# The method we chose is ugly, but it was quick
def write_jwks(jwks_file:str, jwk_json:str) -> None:
    if jwks_file is None:
        return

    # This is the jwk that we need to embend in the JWKS
    jwk_obj = json.loads(jwk_json)

    # Create an empty JWKS
    jwks_string="{ \"keys\": [] }"
    jwks_obj = json.loads(jwks_string)

    # Append the JWK to the JWKS
    jwks_obj["keys"].append(jwk_obj)

    with open(jwks_file, "w", encoding="utf-8") as f:
        json.dump(jwks_obj, f, indent=4)
        f.close


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Write JWK and JWKS files")
    parser.add_argument('--key',  dest='key_file',  help='Path to key file')
    parser.add_argument('--jwk',  dest='jwk_file',  help='Path to output JWK file')
    parser.add_argument('--jwks', dest='jwks_file', help='Path to output JWK file')
    args = parser.parse_args()

try:
    key = pem_to_jwk(args.key_file)
    jwk_json=key.export(private_key=False)
    write_jwk(args.jwk_file,   jwk_json)
    write_jwks(args.jwks_file, jwk_json)
except ValueError as e:
    print(e)
