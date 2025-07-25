FROM codercom/code-server:latest

# Set up npm global path for coder user
ENV NPM_CONFIG_PREFIX=/home/coder/.npm-global
ENV PATH=/home/coder/.npm-global/bin:$PATH

SHELL ["/bin/bash", "-c"]

USER coder

# Create npm global install dir and install Claude CLI
RUN mkdir -p /home/coder/.npm-global && \
    npm install -g @anthropic-ai/claude-code && \
    echo 'export PATH="/home/coder/.npm-global/bin:$PATH"' >> ~/.bashrc && \
    echo 'export PATH="/home/coder/.npm-global/bin:$PATH"' >> ~/.profile && \
    ln -s /home/coder/.npm-global/bin/claude /usr/local/bin/claude || true

WORKDIR /home/coder/project

