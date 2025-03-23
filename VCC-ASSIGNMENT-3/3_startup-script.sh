#!/bin/bash
# this script updates and installs stress tests to make your PC more
# exceed the CPU usage above 75%  with cpu nproc number of processors to use completely
sudo apt update && sudo apt install -y stress-ng
#stress-ng --cpu $(nproc) --cpu-method prime --timeout 120
stress-ng --cpu 4 --timeout 60s
