FROM codercom/code-server:latest

# Set up npm global path for coder user
ENV NPM_CONFIG_PREFIX=/home/coder/.npm-global
ENV PATH=/home/coder/.npm-global/bin:$PATH

# Use bash for the shell
SHELL ["/bin/bash", "-c"]

USER coder

# Create npm global install dir and install Claude CLI
RUN mkdir -p /home/coder/.npm-global && \
    npm install -g @anthropic-ai/claude-code && \
    # Remove existing claude symlink if any, then create a wrapper script
    rm -f /home/coder/.npm-global/bin/claude && \
    echo '#!/bin/bash' > /home/coder/.npm-global/bin/claude && \
    echo 'node /home/coder/.npm-global/lib/node_modules/@anthropic-ai/claude-code/cli.js "$@"' >> /home/coder/.npm-global/bin/claude && \
    chmod +x /home/coder/.npm-global/bin/claude && \
    # Optionally symlink to /usr/local/bin for root user convenience (ignore failure)
    ln -s /home/coder/.npm-global/bin/claude /usr/local/bin/claude || true && \
    echo 'export PATH="/home/coder/.npm-global/bin:$PATH"' >> ~/.bashrc && \
    echo 'export PATH="/home/coder/.npm-global/bin:$PATH"' >> ~/.profile

WORKDIR /home/coder/project
