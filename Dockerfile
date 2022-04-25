FROM debian:bullseye-slim
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends procps nfs-kernel-server

# Copy entrypoint
ADD run_nfs.sh /usr/local/bin/run_nfs.sh

# Create exports dir
RUN mkdir -p /exports	\
 && chmod +x /usr/local/bin/run_nfs.sh

# Export NFS Ports
EXPOSE 20048/tcp 2049/tcp 111/tcp 111/udp

# Expose volume
VOLUME /exports

# Launch entrypoint
ENTRYPOINT ["/usr/local/bin/run_nfs.sh"]

CMD ["/exports"]
