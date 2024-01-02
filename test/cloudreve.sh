sudo wget https://github.com/cloudreve/Cloudreve/releases/download/3.8.3/cloudreve_3.8.3_linux_amd64.tar.gz
tar -zxvf cloudreve_3.8.3_linux_amd64.tar.gz
chmod +x ./cloudreve
echo "
[Unit]
Description=Cloudreve
Documentation=https://docs.cloudreve.org
After=network.target
After=mysqld.service
Wants=network.target

[Service]
WorkingDirectory=/root
ExecStart=/root/cloudreve
Restart=on-abnormal
RestartSec=5s
KillMode=mixed

StandardOutput=null
StandardError=syslog

[Install]
WantedBy=multi-user.target" >> /usr/lib/systemd/system/cloudreve.service
systemctl daemon-reload
systemctl start cloudreve
systemctl enable cloudreve
sudo apt install -y libreoffice libvips-tools ffmpeg

systemctl start cloudreve

systemctl stop cloudreve

systemctl restart cloudreve

systemctl status cloudreve


./cloudreve