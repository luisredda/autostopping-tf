#!/bin/bash

# Update the system
sudo yum update -y

# Install Java 11 (Amazon Corretto)
sudo yum install java-11-amazon-corretto-devel -y

# Download and install Apache Tomcat 10.1.16
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.16/bin/apache-tomcat-10.1.16.tar.gz
tar -xzvf apache-tomcat-10.1.16.tar.gz
sudo mv apache-tomcat-10.1.16 /opt/tomcat/

# Create a new Tomcat user (optional but recommended)
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat/ tomcat

# Set permissions
sudo chown -R tomcat:tomcat /opt/tomcat/
sudo chmod -R g+r /opt/tomcat/conf
sudo chmod g+x /opt/tomcat/conf
sudo chmod -R g+r /opt/tomcat/webapps /opt/tomcat/work /opt/tomcat/temp /opt/tomcat/logs

# Configure Tomcat to run on port 80
sudo sed -i 's/Connector port="8080"/Connector port="80"/' /opt/tomcat/conf/server.xml

sudo setcap 'cap_net_bind_service=+ep' "$JAVA_HOME/bin/java"

# Make the startup script executable
sudo chmod +x /opt/tomcat/bin/startup.sh

# Enable and start Tomcat as a service
sudo tee /etc/systemd/system/tomcat.service << EOF
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat/
Environment=CATALINA_BASE=/opt/tomcat/

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd manager configuration
sudo systemctl daemon-reload

# Start and enable Tomcat service
sudo systemctl start tomcat
sudo systemctl enable tomcat
