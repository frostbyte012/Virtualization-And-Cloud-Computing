sudo apt update
#PROMETHEUS INSTALLATION
sudo apt install prometheus -y
sudo systemctl start prometheus
#Open Grafana at http://localhost:3000 (default login: admin/admin).

#GRAFANA INSTALLATION
sudo apt install -y software-properties-common
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

sudo apt update

sudo apt install grafana -y

sudo systemctl start grafana-server
sudo systemctl enable grafana-server

#http://localhost:3000
#Default login:
# Username: admin
# Password: admin (you will be prompted to change it) 
