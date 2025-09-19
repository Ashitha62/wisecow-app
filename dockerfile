FROM ubuntu:22.04

COPY wisecow/wisecow.sh /wisecow.sh
RUN chmod +x /wisecow.sh

# Install fortune, cowsay, netcat
RUN apt-get update && \
    apt-get install -y fortune-mod netcat curl && \
    curl -L -o /tmp/cowsay.deb http://ftp.us.debian.org/debian/pool/main/c/cowsay/cowsay_3.03+dfsg2-8_all.deb && \
    apt-get install -y /tmp/cowsay.deb && \
    rm -rf /var/lib/apt/lists/* /tmp/cowsay.deb

# Ensure /usr/games is in PATH
ENV PATH="/usr/games:${PATH}"

EXPOSE 4499
CMD ["bash", "./wisecow.sh"]
 
