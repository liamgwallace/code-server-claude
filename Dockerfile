FROM codercom/code-server:latest

# Install Node.js, Python and system dependencies as root
USER root
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs python3 python3-pip python3-venv python3-dev \
    build-essential gcc g++ make git curl wget

# Set up npm global path for coder user
ENV NPM_CONFIG_PREFIX=/home/coder/.npm-global

# Use bash for the shell
SHELL ["/bin/bash", "-c"]

USER coder

# Create npm global install dir and install Claude CLI
RUN mkdir -p /home/coder/.npm-global && \
    npm install -g @anthropic-ai/claude-code

# Install common Python packages
RUN pip3 install --no-cache-dir --break-system-packages \
    requests \
    numpy \
    pandas \
    matplotlib \
    seaborn \
    scipy \
    scikit-learn \
    jupyter \
    jupyterlab \
    notebook \
    pytest \
    pytest-cov \
    black \
    flake8 \
    pylint \
    mypy \
    ipython \
    fastapi \
    uvicorn \
    flask \
    django \
    sqlalchemy \
    psycopg2-binary \
    redis \
    celery \
    python-dotenv \
    pydantic \
    beautifulsoup4 \
    lxml \
    selenium \
    pillow \
    opencv-python-headless

# Install common Node.js packages globally
RUN npm install -g \
    express \
    lodash \
    axios \
    jest \
    mocha \
    chai \
    eslint \
    prettier \
    typescript \
    ts-node \
    nodemon \
    pm2 \
    webpack \
    webpack-cli \
    babel-cli \
    create-react-app \
    vue-cli \
    @angular/cli \
    next \
    nuxt \
    gatsby-cli \
    @nestjs/cli

# Switch to root to create system symlink, then back to coder
USER root
RUN ln -sf /home/coder/.npm-global/bin/claude /usr/local/bin/claude

USER coder

WORKDIR /home/coder/project
