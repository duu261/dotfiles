#!/bin/bash

# CPU Temp (via sensors)
cpu_temp=$(sensors | awk '/Core 0/ {print $3}' | head -1)

# GPU Temp and Load (via nvidia-smi)
gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
gpu_load=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)

# CPU Load (via top or mpstat)
cpu_load=$(mpstat | awk '/all/ {printf "%.2f", 100 - $12}')

# Output hover info
echo -e "CPU Temp: $cpu_temp\nGPU Temp: ${gpu_temp}°C\nCPU Load: ${cpu_load}%\nGPU Load: ${gpu_load}%"

