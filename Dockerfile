FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    git cmake g++ libjson-c-dev libwebsockets-dev libssl-dev make tmux curl

RUN git clone https://github.com/tsl0922/ttyd.git && \
    cd ttyd && mkdir build && cd build && \
    cmake .. && make && make install

RUN useradd -ms /bin/bash renderuser
USER renderuser
WORKDIR /home/renderuser

CMD ["sh", "-c", "tmux new-session -d -s webssh && ttyd -p 10000 tmux attach-session -t webssh"]
