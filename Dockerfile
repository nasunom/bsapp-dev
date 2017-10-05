FROM centos:7.3.1611

RUN yum -y install \
  java-1.8.0-openjdk-devel \
  perl \
  make \
  gcc-c++ \
  bzip2 \
  bzip2-devel \
  ncurses-devel \
  tbb-devel \
  xz-devel \
  zlib-devel \
  && yum clean all

RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python
 && pip install future

RUN curl -L https://github.com/downloads/taoliu/MACS/MACS-1.4.2-1.tar.gz | tar zxf - \
 && cd MACS-1.4.2 && python setup.py install --prefix /usr/local

RUN curl -L https://github.com/arq5x/bedtools2/releases/download/v2.26.0/bedtools-2.26.0.tar.gz | tar zxf - \
 && cd bedtools2 && make && make install

RUN curl -L https://github.com/BenLangmead/bowtie2/archive/v2.3.3.tar.gz | tar zxf - \
  && cd bowtie2-2.3.3 && make && make install

RUN curl -L https://github.com/samtools/samtools/releases/download/1.5/samtools-1.5.tar.bz2 | tar jxf - \
  && cd samtools-1.5 && ./configure && make && make install

RUN rm -rf MACS-1.4.2 bedtools2 bowtie2-2.3.3 samtools-1.5

ENV JAVA_HOME /usr/lib/jvm/java-openjdk
ENV PATH $JAVA_HOME/bin:$PATH
ENV PYTHONPATH /usr/local/lib/python2.7/site-packages

