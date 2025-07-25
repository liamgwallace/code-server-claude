FROM codercom/code-server:latest

# Use bash for the shell
SHELL ["/bin/bash", "-c"]

# Install Claude CLI as root, then create symlink
RUN npm install -g @anthropic-ai/claude-code && \
    ln -sf /usr/local/lib/node_modules/@anthropic-ai/claude-code/cli.js /usr/local/bin/claude && \
    chmod +x /usr/local/bin/claude

USER coder

WORKDIR /home/coder/project
