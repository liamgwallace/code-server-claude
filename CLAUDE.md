# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Docker-based code-server setup that provides a browser-based VS Code environment with Claude Code CLI pre-installed. The project consists of infrastructure configuration files for running code-server in a containerized environment.

## Architecture

The project uses a simple Docker setup:
- **Dockerfile**: Extends `codercom/code-server:latest` and installs Claude Code CLI via npm
- **docker-compose.yml**: Defines the service configuration with volume mounts and Traefik labels
- **README.md**: Contains deployment and usage instructions

## Key Components

### Docker Configuration
- Base image: `codercom/code-server:latest`
- Claude Code CLI installed globally via npm at `/home/coder/.npm-global/bin/claude`
- Custom wrapper script ensures proper execution of Claude CLI
- Runs as `coder` user (PUID=1000, PGID=1000)

### Volume Mounts
- `/home/liam/docker/code-server/workspace` → `/home/coder/project` (workspace files)
- `/home/liam/docker/code-server/config` → `/home/coder/.config` (code-server settings)
- `/home/liam/docker/code-server/claude` → `/home/coder/.claude-code` (Claude auth and cache)

### Networking
- Exposed on port 8443 (maps to container port 8080)
- Configured for Traefik reverse proxy with domain `code.bramleyvale.com`
- Currently configured for HTTP (HTTPS configuration commented out)

## Development Environment

Since this is an infrastructure project focused on containerized development environment setup, there are no traditional build, test, or lint commands. The primary development workflow involves:

1. **Building the container**: `docker-compose build`
2. **Starting the service**: `docker-compose up -d`
3. **Viewing logs**: `docker-compose logs -f`
4. **Stopping the service**: `docker-compose down`

## Authentication

The code-server instance requires password authentication via the `PASSWORD` environment variable. Claude Code CLI authentication is handled separately within the container via the `claude` command.

## Deployment Context

This setup is designed for Portainer-based deployment with Traefik as a reverse proxy, targeting a self-hosted development environment accessible at `code.bramleyvale.com`.