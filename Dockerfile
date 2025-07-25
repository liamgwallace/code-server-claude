FROM codercom/code-server:latest

# Use bash for the shell
SHELL ["/bin/bash", "-c"]

# Install Claude CLI as root
RUN npm install -g @anthropic-ai/claude-code

# Create entrypoint script to ensure claude symlink exists
RUN echo '#!/bin/bash' > /usr/local/bin/setup-claude.sh && \
    echo 'ln -sf /usr/local/lib/node_modules/@anthropic-ai/claude-code/cli.js /usr/local/bin/claude 2>/dev/null || true' >> /usr/local/bin/setup-claude.sh && \
    echo 'chmod +x /usr/local/bin/claude 2>/dev/null || true' >> /usr/local/bin/setup-claude.sh && \
    echo 'exec "$@"' >> /usr/local/bin/setup-claude.sh && \
    chmod +x /usr/local/bin/setup-claude.sh

USER coder

WORKDIR /home/coder/project

ENTRYPOINT ["/usr/local/bin/setup-claude.sh"]
CMD ["dumb-init", "fixuid", "-q", "/usr/bin/code-server", "--bind-addr", "0.0.0.0:8080", "."]
