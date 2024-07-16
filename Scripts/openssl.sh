sudo yum -y update
sudo yum install -y make gcc perl-core pcre-devel wget zlib-devel
# wget https://ftp.openssl.org/source/openssl-3.1.1.tar.gz
wget https://src.fedoraproject.org/lookaside/pkgs/openssl/openssl-3.1.1.tar.gz/sha512/8ba9dd6ab87451e126c19cc106ccd1643ca48667d6c37504d0ab98205fbccf855fd0db54474b4113c4c3a15215a4ef77a039fb897a69f71bcab2054b2effd1d9/openssl-3.1.1.tar.gz
sudo tar -xzvf openssl-3*.tar.gz
cd openssl-3*/
./config --prefix=/usr --openssldir=/etc/ssl --libdir=lib no-shared zlib-dynamic
sudo make -j ${nproc}
sudo make test
sudo make install -j ${nproc}
echo "export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64" >> /etc/profile.d/openssl.sh
source /etc/profile.d/openssl.sh
openssl version
