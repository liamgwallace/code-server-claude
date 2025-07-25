FROM codercom/code-server:latest

# Set up npm global path for coder user
ENV NPM_CONFIG_PREFIX=/home/coder/.npm-global
ENV PATH=$PATH:/home/coder/.npm-global/bin

USER coder

# Create npm global install dir and install Claude CLI as coder
RUN mkdir -p /home/coder/.npm-global && \
    npm install -g @anthropic-ai/claude-code

WORKDIR /home/coder/project
