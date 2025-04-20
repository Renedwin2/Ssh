# Use a lightweight Debian image as base
FROM debian:bullseye

# Install required packages: git, build tools, dependencies for ttyd, tmux, and curl
RUN apt-get update && apt-get install -y \
    git cmake g++ libjson-c-dev libwebsockets-dev libssl-dev make tmux curl

# Clone ttyd repository and compile it
RUN git clone https://github.com/tsl0922/ttyd.git && \
    cd ttyd && mkdir build && cd build && \
    cmake .. && make && make install

# Create a new user for running ttyd
RUN useradd -ms /bin/bash renderuser
USER renderuser
WORKDIR /home/renderuser

# Start ttyd with an interactive tmux session, accessible on port 10000
CMD ["ttyd", "-p", "10000", "-i", "0.0.0.0", "tmux"]
