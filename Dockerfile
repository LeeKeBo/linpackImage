#docker linpack配置镜像，需先在Redhat官网获取Redhat镜像包

FROM 40e 
MAINTAINER lkb xxx@qq.com

#修改源，安装所需依赖
#RUN rm -rf /etc/yum.repos.d/myself.repo && y
ADD myself.repo /etc/yum.repos.d/
RUN yum update -y  && yum makecache && yum downgrade -y glibc glibc-common glibc-devel glibc-headers libstdc++ && yum install -y  gcc gcc-c++ gcc-gfortran wget git make

#创建工作文件夹
RUN mkdir linpack
WORKDIR /root/linpack

#安装mpich
RUN wget http://www.mpich.org/static/downloads/3.3.1/mpich-3.3.1.tar.gz
RUN tar xzvf mpich-3.3.1.tar.gz && cd mpich-3.3.1 && ./configure --prefix=/root/linpack/proc/mpich-3.3.1 && make && make install
ENV PATH /root/linpack/proc/mpich-3.3.1/bin:$PATH
ENV MANPATH /root/linpack/proc/mpich-3.3.1/man:$MANPATH

#安装OpenBLAS
RUN git clone https://github.com/xianyi/OpenBLAS && cd OpenBLAS && make && make PREFIX=/root/linpack/proc/OpenBLAS install
 
#安装HPL
RUN wget http://www.netlib.org/benchmark/hpl/hpl-2.2.tar.gz && tar xf hpl-2.2.tar.gz 
#RUN rm -rf hpl-2.2

WORKDIR /root/linpack/hpl-2.2
#将配置文件放进HPL目录，完成配置
ADD Make.ppc64 /root/linpack/hpl-2.2/
ENV LD_LIBRARY_PATH /root/linpack/proc/OpenBLAS/lib:$LD_LIBRARY_PATH
RUN make arch=ppc64

#安装netperf
RUN mkdir /root/networkTest
WORKDIR /root/networkTest
RUN git clone https://github.com/HewlettPackard/netperf.git
RUN yum install -y autotools-dev   autoconf  automake texinfo
RUN cd netperf && ./autogen.sh && ./configure && make && make install 








