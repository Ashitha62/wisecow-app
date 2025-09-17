FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y cowsay fortune-mod netcat && \
    rm -rf /var/lib/apt/lists/*

# Copy your script
COPY wisecow.sh /wisecow.sh
RUN chmod +x /wisecow.sh

# Expose port
EXPOSE 4499

# Start script
CMD ["/wisecow.sh"]
