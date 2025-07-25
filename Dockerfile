FROM codercom/code-server:latest

USER root

# Install curl and bash (required for Node.js install script)
RUN apt-get update && \
    apt-get install -y curl ca-certificates gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure npm global install directory
ENV NPM_CONFIG_PREFIX=/home/coder/.npm-global
ENV PATH=$PATH:/home/coder/.npm-global/bin

# Install Claude CLI
RUN npm install -g @anthropic-ai/claude-code

USER coder
WORKDIR /home/coder/project
