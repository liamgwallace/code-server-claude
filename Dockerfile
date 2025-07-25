FROM codercom/code-server:latest

# Set up npm global path for coder user
ENV NPM_CONFIG_PREFIX=/home/coder/.npm-global
ENV PATH=/home/coder/.npm-global/bin:$PATH

# Use bash for the shell
SHELL ["/bin/bash", "-c"]

USER coder

# Create npm global install dir and install Claude CLI, then create system symlink
RUN mkdir -p /home/coder/.npm-global && \
    npm install -g @anthropic-ai/claude-code && \
    # Switch to root to create system-wide symlink, then back to coder
    sudo ln -sf /home/coder/.npm-global/lib/node_modules/@anthropic-ai/claude-code/cli.js /usr/local/bin/claude && \
    sudo chmod +x /usr/local/bin/claude

WORKDIR /home/coder/project
