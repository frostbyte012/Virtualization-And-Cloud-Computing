import requests
import time
import subprocess

PROMETHEUS_URL = "http://localhost:9090/api/v1/query"
GCP_INSTANCE_TEMPLATE = "auto-scale-template"
GCP_INSTANCE_GROUP = "auto-scaling-group"

def get_cpu_usage():
    query = 'rate(node_cpu_seconds_total{mode!="idle"}[1m])'
    response = requests.get(PROMETHEUS_URL, params={'query': query})
    data = response.json()

    if 'data' in data and 'result' in data['data'] and len(data['data']['result']) > 0:
        cpu_usage = float(data['data']['result'][0]['value'][1]) * 100
        return round(cpu_usage, 2)
    return 0

def trigger_gcp_auto_scaling():
    print("⚠ High CPU detected! Scaling up GCP instances...")
    command = f"gcloud compute instance-groups managed set-autoscaling {GCP_INSTANCE_GROUP} --max-instances 5 --target-cpu-utilization 0.75 --cool-down-period 60 --region us-central1"
    subprocess.run(command, shell=True)

while True:
    cpu = get_cpu_usage()
    print(f"Current CPU Usage: {cpu}%")

    if cpu > 75:
        trigger_gcp_auto_scaling()

    time.sleep(10)
