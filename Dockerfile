FROM docker.io/bitnami/postgresql-repmgr:17.6.0-debian-12-r2

# Metadata
LABEL maintainer="Sahra Tech <contact@sahra-tech.com>"
LABEL description="PostgreSQL with Repmgr and Jalali Utils extension for Persian calendar support"
LABEL version="17.6.0"

# Switch to root to install packages
USER root

# Install required dependencies for building extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    postgresql-server-dev-15 \
    ca-certificates \
    make \
    && rm -rf /var/lib/apt/lists/*

# Create extension build directory
RUN mkdir -p /tmp/extensions

# Clone and build the Jalali Utils extension
RUN git clone https://github.com/teamappir/jalali_utils.git /tmp/extensions/jalali_utils \
    && cd /tmp/extensions/jalali_utils \
    && make clean \
    && make \
    && make install \
    && ls -la /opt/bitnami/postgresql/share/extension/jalali_utils*

# Clean up build dependencies and temporary files
RUN apt-get purge -y --auto-remove \
    git \
    build-essential \
    postgresql-server-dev-15 \
    && rm -rf /tmp/extensions \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Switch back to the default bitnami user
USER 1001

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD pg_isready -U postgres || exit 1

# Expose PostgreSQL port
EXPOSE 5432
