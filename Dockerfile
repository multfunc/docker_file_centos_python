FROM centos:7
RUN yum update -y
RUN yum install -y kde-l10n-Chinese&&yum reinstall -y glibc-common && localedef -c -f UTF-8 -i zh_CN zh_CN.UFT-8 && export LANG=zh_CN.UTF-8 && echo "export LANG=zh_CN.UTF-8" >> /etc/locale.conf
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8
RUN rm -rf /etc/localtime&&ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum install -y gcc glibc g++ gcc-c++ make automake autoconf libtool  zlib* libffi-devel openssl-devel openssl net-tools  unzip zip
ADD ./Python-3.8.0.tgz /opt/python
WORKDIR /opt/python/Python-3.8.0
RUN ./configure --prefix=/usr/local/
RUN make&&make altinstall
WORKDIR /opt/python
RUN ln -s /usr/local/bin/python3.8 /usr/bin/python3&&ln -s /usr/local/bin/pip3.8 /usr/bin/pip3&&pip3 install --upgrade pip&&pip3 install pipenv
RUN yum install -y telnet-server telnet net-tools
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
ADD ./nginx-1.17.0.tar.gz /opt/nginx
WORKDIR /opt/nginx/nginx-1.17.0
