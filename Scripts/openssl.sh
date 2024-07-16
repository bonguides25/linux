#!/bin/bash

version=$(cat /etc/os-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/["]//g' | awk '{print $1}')
version_id=$(cat /etc/os-release | grep "VERSION_ID" | sed 's/VERSION_ID=//g' | sed 's/["]//g' | awk '{print $1}')

if [ $version == "CentOS" ] && [ $version_id == "7" ]
then

  sudo sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
  sudo sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
  sudo sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo
  sudo -- bash -c 'echo "sslverify=false" >> /etc/yum.conf'

  sudo yum -y update
  sudo yum install -y make gcc perl-core pcre-devel wget zlib-devel
  # wget https://ftp.openssl.org/source/openssl-3.1.1.tar.gz
  wget https://www.openssl.org/source/openssl-3.1.6.tar.gz
  sudo tar -xzvf openssl-3*.tar.gz
  cd openssl-3*/
  ./config --prefix=/usr --openssldir=/etc/ssl --libdir=lib no-shared zlib-dynamic
  sudo make -j ${nproc}
  sudo make test
  sudo make install -j ${nproc}
  echo "export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64" >> /etc/profile.d/openssl.sh
  source /etc/profile.d/openssl.sh
  openssl version
  
fi

if [ $version == "CentOS" ] && [ $version_id == "8" ]
then

  sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*
  sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.epel.cloud|g' /etc/yum.repos.d/CentOS-Linux-*
  sed -i 's/mirrorlist/mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*
  sed -i 's|baseurl=http://mirror.centos.org|baseurl=http://vault.epel.cloud|g' /etc/yum.repos.d/CentOS-Linux-*
  sudo -- bash -c 'echo "sslverify=false" >> /etc/yum.conf'

  sudo dnf -y update
  sudo dnf install -y make gcc perl-core pcre-devel wget zlib-devel
  # wget https://ftp.openssl.org/source/openssl-3.1.1.tar.gz
  wget https://www.openssl.org/source/openssl-3.1.6.tar.gz
  sudo tar -xzvf openssl-3*.tar.gz
  cd openssl-3*/
  ./config --prefix=/usr --openssldir=/etc/ssl --libdir=lib no-shared zlib-dynamic
  sudo make -j ${nproc}
  sudo make test
  sudo make install -j ${nproc}
  echo "export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64" >> /etc/profile.d/openssl.sh
  source /etc/profile.d/openssl.sh
  openssl version

fi


