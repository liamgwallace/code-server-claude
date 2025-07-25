FROM codercom/code-server:latest

# Set up npm global path for coder user
ENV NPM_CONFIG_PREFIX=/home/coder/.npm-global
ENV PATH=/home/coder/.npm-global/bin:$PATH

USER coder

# Create npm global install dir, install Claude CLI, and fix PATH in shell sessions
RUN mkdir -p /home/coder/.npm-global && \
    npm install -g @anthropic-ai/claude-code && \
    echo 'export PATH="/home/coder/.npm-global/bin:$PATH"' >> ~/.bashrc && \
    echo 'export PATH="/home/coder/.npm-global/bin:$PATH"' >> ~/.profile

WORKDIR /home/coder/project
