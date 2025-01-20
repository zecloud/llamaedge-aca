#!/bin/bash

# Créer le répertoire models s'il n'existe pas (il devrait être monté en tant que volume)
#mkdir -p models
if [ ! -d "models" ]; then
    mkdir -p models
fi
# Check if model file exists
if [ ! -f "models/phi-4-q4.gguf" ]; then
# Télécharger le fichier dans le répertoire models
    curl -L "https://huggingface.co/microsoft/phi-4-gguf/resolve/main/phi-4-q4.gguf?download=true" -o models/phi-4-q4.gguf
fi

wasmedge --dir .:. --nn-preload default:GGML:AUTO:models/phi-4-q4.gguf llama-api-server.wasm --prompt-template  phi-4-chat --ctx-size  16000 --model-name phi-3-mini --socket-addr 0.0.0.0:8080