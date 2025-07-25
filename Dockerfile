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
    # Option 1: Symlink Claude binary to a location always in $PATH
    ln -s /home/coder/.npm-global/bin/claude /usr/local/bin/claude || true

# --- Optional: uncomment if you prefer PATH export via shell profile (Option 2) ---
# RUN echo 'export PATH="/home/coder/.npm-global/bin:$PATH"' >> ~/.bashrc && \
#     echo 'export PATH="/home/coder/.npm-global/bin:$PATH"' >> ~/.profile

WORKDIR /home/coder/project
