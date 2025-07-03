#!/bin/bash

# Prompt for GPG passphrase and decrypt secrets
gpg --quiet --batch --yes --decrypt --output secrets/secrets.json secrets/secrets.json.gpg
