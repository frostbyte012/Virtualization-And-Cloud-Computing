source /home/deepraj/Desktop/VCC/Assignments/Three/venv/bin/activate
pip list | grep google-cloud-compute
stress-ng --cpu 4 --timeout 2m
python /home/deepraj/Desktop/VCC/Assignments/Three/8_autoscale.py
gcloud compute instance-groups list


