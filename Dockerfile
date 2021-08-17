FROM debian:sid-slim

RUN apt-get update && \
    apt-get install -y \
    radare2 \
    binwalk \
    gdb \
    vim \
    wget \
    curl \
    python3-pip \
    procps \
    zsh && \

# Cleanup
    rm -rf /var/lib/apt/lists/*    

WORKDIR /workdir

# Add GEF
RUN wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh

# Install python modules for GEF
RUN pip install keystone-engine
RUN pip install unicorn
RUN pip install capstone
RUN pip install ropper
RUN pip install keystone-engine

# Add local files
ADD ./bash_tweaks/* /root/
RUN mv /root/motd /etc/motd
ADD ./configs/.radare2rc /root/
ADD entrypoint.sh /opt/
# fix encoding bug
#RUN sed -i 's/\\u27a4 />/g' ~/.gef*

ENTRYPOINT /opt/entrypoint.sh 
