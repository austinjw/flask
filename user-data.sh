#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
 curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
   /usr/share/keyrings/jenkins-keyring.asc > /dev/null
 echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
   https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
   /etc/apt/sources.list.d/jenkins.list > /dev/null
 apt-get -y update
 apt-get -y install openjdk-11-jre
 apt-get -y install python3
 apt-get -y install jenkins
 curl -L -O https://github.com/github/codeql-action/releases/latest/download/codeql-bundle-linux64.tar.gz
 tar -xvzf ./codeql-bundle-linux64.tar.gz
 rm ./codeql-bundle-linux64.tar.gz
 mv ./codeql /opt
 mkdir -p /codeql-dbs/example-repo-multi
 chown -R jenkins /codeql-dbs
 chown -R jenkins /opt/codeql
