FROM codercom/code-server:latest

# Set up npm global path for coder user
ENV NPM_CONFIG_PREFIX=/home/coder/.npm-global
ENV PATH=/home/coder/.npm-global/bin:$PATH

# Use bash for the shell
SHELL ["/bin/bash", "-c"]

USER coder

# Create npm global install dir and install Claude CLI
RUN mkdir -p /home/coder/.npm-global && \
    npm install -g @anthropic-ai/claude-code

# Switch back to root to create system-wide symlink
USER root
RUN ln -sf /home/coder/.npm-global/lib/node_modules/@anthropic-ai/claude-code/cli.js /usr/local/bin/claude && \
    chmod +x /usr/local/bin/claude

# Switch back to coder user
USER coder

WORKDIR /home/coder/project
