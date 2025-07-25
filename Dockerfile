FROM codercom/code-server:latest

# Install Node.js (Claude CLI requires 18+)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Configure npm global install directory
ENV NPM_CONFIG_PREFIX=/home/coder/.npm-global
ENV PATH=$PATH:/home/coder/.npm-global/bin

# Install Claude Code CLI
RUN npm install -g @anthropic-ai/claude-code

# Set working directory
WORKDIR /home/coder/project
