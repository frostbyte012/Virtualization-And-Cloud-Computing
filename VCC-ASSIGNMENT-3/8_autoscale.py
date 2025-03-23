import requests
from google.cloud import compute_v1

PROMETHEUS_URL = "http://localhost:9090/api/v1/query"
QUERY = '100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[1m])) * 100)'

def get_cpu_usage():
    response = requests.get(PROMETHEUS_URL, params={'query': QUERY})
    data = response.json()
    if data['status'] == 'success' and data['data']['result']:
        return float(data['data']['result'][0]['value'][1])
    return 0

def scale_gcp_instances():
    instance_client = compute_v1.InstanceGroupManagersClient()  # Zonal, not regional
    project_id = "vcc-assignment-3-454521"
    zone = "us-central1-a"  # Use zone instead of region
    group_name = "auto-scale-group"
    
    request = compute_v1.ResizeInstanceGroupManagerRequest(
        project=project_id,
        zone=zone,
        instance_group_manager=group_name,
        size=2  # Increase instances when CPU exceeds 75%
    )
    instance_client.resize_unary(request)

if __name__ == "__main__":
    cpu_usage = get_cpu_usage()
    print(f"Current CPU Usage: {cpu_usage}%")
    
    if cpu_usage > 75:
        print("CPU usage exceeded 75%, scaling up...")
        scale_gcp_instances()
    else:
        print("CPU usage is normal.")

