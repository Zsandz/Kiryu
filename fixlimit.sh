#!/bin/bash
clear
REPO="https://raw.githubusercontent.com/Zsandz/kiryu/main/"
systemctl stop vmip vlip trip
cd /usr/bin
rm -rf limit-ip
cd
wget -q -O /usr/bin/limit-ip "${REPO}Fls/limit-ip"
chmod +x /usr/bin/*
cd /usr/bin
sed -i 's/\r//' limit-ip
cd
clear
cat >/etc/systemd/system/vmip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vmip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart vmip
systemctl enable vmip
cat >/etc/systemd/system/vlip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vlip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart vlip
systemctl enable vlip
cat >/etc/systemd/system/trip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip trip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart trip
systemctl enable trip
clear
figlet "Zero"
echo "Succesfully fixed limit login xray"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
rm -rf fixlimit.sh
