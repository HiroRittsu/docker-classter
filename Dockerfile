FROM ubuntu:18.04　

RUN apt-get update && \
    apt-get install -y openssh-server && \    
    apt-get install -y sshfs

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:longsleep/golang-backports && \
    apt-get update && \
    apt-get install -y language-pack-ja-base language-pack-ja && \
    apt-get install -y less man curl wget git unzip bzip2 vim emacs && \
    apt-get install -y build-essential gcc clang zlib1g-dev libeigen3-dev cmake libgl1-mesa-dev && \
    apt-get install -y python3 python3-dev python3-pip python3-venv python3-setuptools && \
    apt-get install -y mysql-server golang-go

RUN sed -i.bak 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -m docker && \
    echo "docker:docker" | chpasswd

ENTRYPOINT ["/bin/sh", "-c", "/etc/init.d/ssh start; while :; do sleep 5; done"]

