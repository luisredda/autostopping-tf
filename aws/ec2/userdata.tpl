#!/bin/bash

# Update the system
sudo yum update -y

# Install Java 11 (Amazon Corretto)
sudo yum install java-11-amazon-corretto-devel -y

# Download and install Apache Tomcat 10.1.16
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.16/bin/apache-tomcat-10.1.16.tar.gz
tar -xzvf apache-tomcat-10.1.16.tar.gz
sudo mv apache-tomcat-10.1.16 /opt/tomcat/apache-tomcat-10.1.16

# Create a new Tomcat user (optional but recommended)
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat/apache-tomcat-10.1.16 tomcat

# Set permissions
sudo chown -R tomcat:tomcat /opt/tomcat/apache-tomcat-10.1.16
sudo chmod -R g+r /opt/tomcat/apache-tomcat-10.1.16/conf
sudo chmod g+x /opt/tomcat/apache-tomcat-10.1.16/conf
sudo chmod -R g+r /opt/tomcat/apache-tomcat-10.1.16/webapps /opt/tomcat/apache-tomcat-10.1.16/work /opt/tomcat/apache-tomcat-10.1.16/temp /opt/tomcat/apache-tomcat-10.1.16/logs

# Configure Tomcat to run on port 80
sudo sed -i 's/Connector port="8080"/Connector port="80"/' /opt/tomcat/apache-tomcat-10.1.16/conf/server.xml

# Create a simplified Tomcat startup script
sudo tee /opt/tomcat/apache-tomcat-10.1.16/bin/startup.sh << 'EOF'
#!/bin/bash

export CATALINA_HOME="/opt/tomcat/apache-tomcat-10.1.16"
export CATALINA_BASE="/opt/tomcat/apache-tomcat-10.1.16"
export CATALINA_PID="$CATALINA_BASE/temp/tomcat.pid"
export JAVA_HOME="/usr/lib/jvm/java-11-amazon-corretto"

"$CATALINA_HOME/bin/startup.sh"
EOF

# Make the startup script executable
sudo chmod +x /opt/tomcat/apache-tomcat-10.1.16/bin/startup.sh

# Enable and start Tomcat as a service
sudo tee /etc/systemd/system/tomcat.service << EOF
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto
Environment=CATALINA_PID=/opt/tomcat/apache-tomcat-10.1.16/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat/apache-tomcat-10.1.16
Environment=CATALINA_BASE=/opt/tomcat/apache-tomcat-10.1.16

ExecStart=/opt/tomcat/apache-tomcat-10.1.16/bin/startup.sh
ExecStop=/opt/tomcat/apache-tomcat-10.1.16/bin/shutdown.sh

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
