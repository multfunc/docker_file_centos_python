FROM centos:7
RUN yum update -y
RUN yum -y install gcc glibc g++ gcc-c++ make automake autoconf libtool  zlib* libffi-devel openssl-devel openssl net-tools  unzip zip
ADD ./Python-3.7.3.tgz /opt/python
WORKDIR /opt/python/Python-3.7.3
RUN pwd&&ls
RUN ./configure --prefix=/usr/local/
RUN make&&make altinstall
WORKDIR /opt/python
ADD ./urlgrabber-ext-down /usr/libexec/urlgrabber-ext-down
ADD ./yum /usr/bin/yum
RUN mv /usr/bin/python /usr/bin/python.backup&&ln -s /usr/local/bin/python3.7 /usr/bin/python3&&ln -s /usr/local/bin/python3.7 /usr/bin/python&&ln -s /usr/local/bin/pip3.7 /usr/bin/pip3
RUN pip3 install --upgrade pip
RUN yum install -y telnet-server telnet net-tools
RUN pip3 install pipenv
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
ADD ./nginx-1.17.0.tar.gz /opt/nginx
WORKDIR /opt/nginx/nginx-1.17.0
RUN ./configure&&make&&make install
RUN rm -rf /etc/localtime&&ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
