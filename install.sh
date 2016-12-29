#!/bin/bash

mkdir /usr/local/src
ln -s /usr/local/src /src

JAVA_INSTALL=/usr/local/src/lib/java
TOMCAT_INSTALL=/usr/local/src/lib/tomcat
ANT_INSTALL=/usr/local/src/lib/ant

JAVA_HOME=${JAVA_INSTALL}/default
CATALINA_HOME=${TOMCAT_INSTALL}/default
ANT_HOME=${ANT_INSTALL}/default

mkdir -p ${JAVA_INSTALL} 
mkdir -p ${TOMCAT_INSTALL} 
mkdir -p ${ANT_INSTALL} 

apt-get install -y unzip

cd ${JAVA_INSTALL} 
wget -O openjdk.zip https://github.com/ojdkbuild/ojdkbuild/releases/download/1.8.0.111-1/java-1.8.0-openjdk-1.8.0.111-0.b15.el6_8.x86_64.zip
sleep 1s
unzip openjdk*.zip -d ${JAVA_INSTALL} 
rm openjdk*.zip
ln -s *openjdk* default

cd ${TOMCAT_INSTALL} 
wget -O apache-tomcat.tar.gz http://apache.communilink.net/tomcat/tomcat-9/v9.0.0.M15/bin/apache-tomcat-9.0.0.M15.tar.gz
sleep 1s
tar zxf apache-tomcat*.tar.gz -C ${TOMCAT_INSTALL}
rm apache-tomcat*.tar.gz
ln -s apache-tomcat* default
cd ./default/webapps
tar zcf manager.tar.gz ./host-manager/ ./manager/ ./examples ./docs
rm -rf ./ROOT/*
rm -rf ./docs
rm -rf ./examples
rm -rf ./host-manager
rm -rf ./manager

cd ${ANT_INSTALL}
wget -O apache-ant.tar.gz http://ftp.cuhk.edu.hk/pub/packages/apache.org/ant/binaries/apache-ant-1.9.7-bin.tar.gz
sleep 1s
tar zxf apache-ant*.tar.gz -C ${ANT_INSTALL}
rm apache-ant*.tar.gz
ln -s apache-ant* default

debconf-set-selections <<< 'mysql-server mysql-server/root_password password '$DEV_PWD
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password '$DEV_PWD
apt-get install -y mysql-server

