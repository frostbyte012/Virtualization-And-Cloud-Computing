gcloud compute instance-groups managed set-autoscaling auto-scale-group \
  --zone us-central1-a \
  --target-cpu-utilization 0.75 \
  --cool-down-period 90 \
  --max-num-replicas 5 \
  --min-num-replicas 1
