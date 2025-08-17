FROM ghcr.io/zalando/spilo-17:4.0-p2

# Install required dependencies for Git and compiling extensions
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    postgresql-server-dev-17

# Clone the extension from GitHub (replace with the desired Git repository)
RUN git clone https://github.com/teamappir/jalali_utils /extensions/extension

# Install the extension (assuming it's a PostgreSQL extension)
RUN cd /extensions/extension && make && make install

# Clean up
RUN rm -rf /extensions