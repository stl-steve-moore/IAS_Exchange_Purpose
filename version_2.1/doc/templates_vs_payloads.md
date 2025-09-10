# Templates vs Payloads

The templates folder contains files with the format specified for JWT formulation.
One example is templates/jwt_header.json which contains the small number of fields used to create the JWT header.
These template files contain some fields with fixed values and other fields with variables that will be filled in later.
See below for a description of variables.

The payloads folder contains example JSON payloads.
In this work, the payload combines fields required of a JWT (e.g., iss) and fields that further identify the patient as called out in the *SOP IAS Exchange Purpose Implementation* document.
Each payload file is similar to the template files described above with a combination of fields with fixed values and values that are variables.
We chose not to create one payload template that would have numerous variables for the many patient-centric fields.
This level of abstraction would have yielded too many variables for no good reason.
