gcloud auth list
gcloud projects add-iam-policy-binding vcc-assignment-3-454521 \
    --member="user:m23cse012@iitj.ac.in" \
    --role="roles/compute.instanceAdmin"
gcloud projects add-iam-policy-binding vcc-assignment-3-454521 \
    --member="user:m23cse012@iitj.ac.in" \
    --role="roles/compute.viewer"
gcloud projects add-iam-policy-binding vcc-assignment-3-454521 \
    --member="user:m23cse012@iitj.ac.in" \
    --role="roles/compute.networkViewer"
gcloud projects add-iam-policy-binding vcc-assignment-3-454521 \
    --member="user:m23cse012@iitj.ac.in" \
    --role="roles/editor"
