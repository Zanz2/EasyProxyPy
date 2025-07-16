FROM python:3.11-slim

# Install system dependencies for NordVPN CLI
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        apt-transport-https \
        ca-certificates \
        gnupg \
        iproute2 \
        iptables \
        procps \
        systemctl \
        sudo \
        curl

# Install NordVPN CLI
# Download and run the NordVPN install script
RUN curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh -o /tmp/install.sh \
    && sh  /tmp/install.sh -n


# Install proxy.py
RUN pip install --no-cache-dir proxy.py;

COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose the default proxy.py port
EXPOSE 8899

# Start NordVPN daemon and proxy.py
ENTRYPOINT ["/start.sh"]
