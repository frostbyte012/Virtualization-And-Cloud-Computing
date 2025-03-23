#!/bin/bash

# Install Google Cloud SDK
curl -s https://sdk.cloud.google.com | bash

# Restart the shell to apply changes
exec -l $SHELL

# Initialize gcloud
gcloud init

