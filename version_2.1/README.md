# Examples in this folder are based on Exchange Purpose (XP) Implementation SOP: Individual Access Services (IAS)

 - SOP IAS XP Version 2.1
 - April 11, 2025

## Disclaimers
All files (data, software, documentation, ...) are the work product of the authors and have not been reviewed or approved by any organization, Standards Development Organization or other interested group or committee.
Use these files as examples only and refer to relevant specifications.

## Contributors
 - Steve Moore

# Brief instructions
1. This software runs on Linux and MacOS systems.
There are likely packages you will need to install.

2. Review scripts/pem_to_jwk.sh and scripts/pem_to_jwks.sh
These rely on a Python virtual environment.
You do not need a virtual environment, but you will
need Python3 and these packages

```
/opt/python-venv/bin/pip3 list

Package           Version
----------------- -------
cffi              1.17.1
cryptography      44.0.3
jwcrypto          1.5.6
pip               25.0
pycparser         2.22
PyJWT             2.10.0
typing_extensions 4.13.2
```

3. Run this one time: `./scripts/setup.sh`

This creates:
 - public/private key files in the rsa folder.
 - JWK and JWKS files in the jwk folder.  The JWKS file is one that would be hosted by the identity provider.
 - openid-files/openid-configuration which is a file that would be hosted by the identify provider.

4. Run this one or more times: `./scripts/all.sh`

This creates jwt files for different subjects.
Look in the jwt folder.
