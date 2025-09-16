FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y netcat fortune && \
    apt-get clean

COPY app/wisecow.sh /app/wisecow.sh
WORKDIR /app
RUN chmod +x wisecow.sh

EXPOSE 8080
CMD ["./wisecow.sh"]
