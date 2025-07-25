FROM codercom/code-server:latest

# Install Node.js and npm as root
USER root
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Set up npm global path for coder user
ENV NPM_CONFIG_PREFIX=/home/coder/.npm-global

# Use bash for the shell
SHELL ["/bin/bash", "-c"]

USER coder

# Create npm global install dir and install Claude CLI
RUN mkdir -p /home/coder/.npm-global && \
    npm install -g @anthropic-ai/claude-code

# Switch to root to create system symlink, then back to coder
USER root
RUN ln -sf /home/coder/.npm-global/bin/claude /usr/local/bin/claude

USER coder

WORKDIR /home/coder/project
