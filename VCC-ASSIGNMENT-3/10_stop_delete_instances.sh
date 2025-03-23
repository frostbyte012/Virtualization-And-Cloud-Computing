#resizing group
#gcloud compute instance-groups managed resize auto-scale-group \
#    --zone=us-central1-a --size=0

#Deleting Instance group
#gcloud compute instance-groups managed delete auto-scale-group --zone=us-central1-a

#Stop Individual Instances
#gcloud compute instances list
#gcloud compute instances stop INSTANCE_NAME --zone=us-central1-a

#
