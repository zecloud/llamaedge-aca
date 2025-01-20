FROM nvidia/cuda:12.6.3-base-ubuntu22.04 AS runtime

RUN apt-get update && apt-get install -y curl libcublas-12-6 && \ 
    rm -rf /var/lib/apt/lists

WORKDIR /home

RUN curl -sSf https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/install_v2.sh | bash -s -- --version=0.16.1 --ggmlcuda=12
RUN curl -LO https://github.com/LlamaEdge/LlamaEdge/releases/latest/download/llama-api-server.wasm

COPY rstart.sh /home/rstart.sh
RUN chmod +x /home/rstart.sh

ENTRYPOINT ["/home/rstart.sh"]

