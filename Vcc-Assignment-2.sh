#!/bin/bash

# Variables
PROJECT_ID="vcc-assignment-2-452508"
INSTANCE_TEMPLATE="my-ubuntu-template"
INSTANCE_GROUP="my-instance-group"
ZONE="us-central1-a"
REGION="us-central1"
MACHINE_TYPE="e2-medium"
HEALTH_CHECK="my-health-check"
BACKEND_SERVICE="my-backend-service"
URL_MAP="my-url-map"
FORWARDING_RULE="my-forwarding-rule"
TARGET_PROXY="my-http-proxy"
FIREWALL_RULE="allow-http"

# Set Project
gcloud config set project $PROJECT_ID

# Step 1: Create an Instance Template
gcloud compute instance-templates create $INSTANCE_TEMPLATE \
    --machine-type=$MACHINE_TYPE \
    --image-family=ubuntu-2004-lts \
    --image-project=ubuntu-os-cloud \
    --boot-disk-size=10GB \
    --boot-disk-type=pd-standard \
    --network=default \
    --tags=http-server

# Step 2: Create a Managed Instance Group (MIG)
gcloud compute instance-groups managed create $INSTANCE_GROUP \
    --base-instance-name=my-instance \
    --size=1 \
    --template=$INSTANCE_TEMPLATE \
    --zone=$ZONE

# Step 3: Configure Autoscaling (Scale between 1 and 5 instances based on CPU usage)
gcloud compute instance-groups managed set-autoscaling $INSTANCE_GROUP \
    --max-num-replicas=5 \
    --min-num-replicas=1 \
    --target-cpu-utilization=0.6 \
    --cool-down-period=60 \
    --zone=$ZONE

# Step 4: Create a Health Check
gcloud compute health-checks create http $HEALTH_CHECK \
    --port 80

# Step 5: Create a Backend Service and Attach Instance Group
gcloud compute backend-services create $BACKEND_SERVICE \
    --protocol=HTTP \
    --health-checks=$HEALTH_CHECK \
    --global

gcloud compute backend-services add-backend $BACKEND_SERVICE \
    --instance-group=$INSTANCE_GROUP \
    --instance-group-zone=$ZONE \
    --global

# Step 6: Create a URL Map
gcloud compute url-maps create $URL_MAP \
    --default-service=$BACKEND_SERVICE

# Step 7: Create a Target HTTP Proxy
gcloud compute target-http-proxies create $TARGET_PROXY \
    --url-map=$URL_MAP

# Step 8: Create a Global Forwarding Rule
gcloud compute forwarding-rules create $FORWARDING_RULE \
    --global \
    --target-http-proxy=$TARGET_PROXY \
    --ports=80

# Step 9: Create a Firewall Rule to Allow HTTP Traffic
gcloud compute firewall-rules create $FIREWALL_RULE \
    --allow=tcp:80 \
    --target-tags=http-server \
    --source-ranges=0.0.0.0/0

echo "GCP Auto-scaling and Load Balancer Setup Completed!"
