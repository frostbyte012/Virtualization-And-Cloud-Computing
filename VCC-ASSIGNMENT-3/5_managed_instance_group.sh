gcloud compute instance-groups managed create auto-scale-group \
  --base-instance-name auto-scale \
  --size 1 \
  --template auto-scale-template \
  --zone us-central1-a

