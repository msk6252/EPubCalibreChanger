FROM amazonlinux

SHELL ["/bin/bash", "-c"]

RUN yum update &&\
    yum install -y wget sudo tar curl xz unzip libglib2.0-0 libsm6 libxrender1 libxext6 mesa-libGL.x86_64

RUN curl -OL https://download.calibre-ebook.com/5.28.0/calibre-5.28.0-x86_64.txz

RUN curl -OL https://github.com/apprenticeharper/DeDRM_tools/releases/download/v7.2.1/DeDRM_tools_7.2.1.zip

RUN sudo mkdir -p /opt/calibre &&\
    sudo rm -rf /opt/calibre/* &&\
    sudo tar xvf /calibre-5.28.0-x86_64.txz -C /opt/calibre &&\
    sudo /opt/calibre/calibre_postinstall

RUN sudo rm -rf DeDRM_tools && sudo unzip /DeDRM_tools_7.2.1.zip

RUN /opt/calibre/calibre-customize -a /DeDRM_plugin.zip
RUN /opt/calibre/calibre-customize -a /Obok_plugin.zip
