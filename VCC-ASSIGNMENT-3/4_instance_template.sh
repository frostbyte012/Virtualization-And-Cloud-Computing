gcloud compute instance-templates create auto-scale-template \
  --machine-type=e2-micro \
  --image-family=ubuntu-2204-lts \
  --image-project=ubuntu-os-cloud \
  --boot-disk-size=10GB \
  --tags=http-server \
  --metadata=startup-script="#! /bin/bash
    sudo apt update
    sudo apt install -y stress-ng"

