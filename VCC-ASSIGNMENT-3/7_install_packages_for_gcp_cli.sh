sudo apt update && sudo apt install -y python3-pip
sudo ln -s /usr/bin/pip3 /usr/bin/pip
pip --version
sudo apt install python3.12-venv -y
python3 -m venv venv
source venv/bin/activate
pip install google-cloud-compute
