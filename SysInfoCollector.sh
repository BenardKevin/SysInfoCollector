#!/bin/bash

USERNAME=$(whoami)
OUTPUT="Mac_${USERNAME}.txt"

echo "********************************************************"
echo "Collecte des informations du Mac en cours..."
echo "********************************************************"

echo "=== Informations système du Mac ===" > "$OUTPUT"
echo "Hostname: $(hostname)" >> "$OUTPUT"
echo "Hostname ... Done"
echo "Model: $(system_profiler SPHardwareDataType | awk -F': ' '/Model Name|Model Identifier/ {print $2}' | paste -sd ' ')" >> "$OUTPUT"
echo "Constructeur ... Done"
echo "OS: $(sw_vers -productName) $(sw_vers -productVersion)" >> "$OUTPUT"
echo "OS ... Done"
echo "Adresse MAC:" >> "$OUTPUT"
networksetup -listallhardwareports | awk '/Hardware Port|Device|Ethernet Address/ {print}' >> "$OUTPUT"
echo "Mac ... Done"
echo "Configuration IP:" >> "$OUTPUT"
ipconfig getifaddr en0 >> "$OUTPUT"
ipconfig getifaddr en1 >> "$OUTPUT"
echo "IP ... Done"

echo "********************************************************"
echo "Fichier généré : $OUTPUT"
echo "********************************************************"
