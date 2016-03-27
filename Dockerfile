FROM alpine:edge

ADD repositories /etc/apk/repositories

RUN apk --no-cache add bash build-base capstone-dev@testing curl file gdb git patch python-dev py-pip

WORKDIR /opt/

VOLUME /workdir

# Install radare2
RUN git clone https://github.com/radare/radare2.git && \
    radare2/sys/install.sh

# Install peda
RUN git clone https://github.com/longld/peda.git && \
    echo "source peda/peda.py" >> ~/.gdbinit

# Install volatility
RUN git clone https://github.com/volatilityfoundation/volatility.git && \
    chmod +x volatility/vol.py && \
    ln -s /opt/volatility/vol.py /usr/bin/volatility

# Install additional plugins for volatility
RUN pip install distorm3 openpyxl ujson pycrypto

WORKDIR /workdir

ENTRYPOINT bash