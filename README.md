# 🧠 code-server + Claude Code

This stack runs a fully browser-based VS Code environment with [Claude Code CLI](https://docs.anthropic.com/claude-code) integrated, so you can chat with Claude directly in your terminal or editor.

---

## 🚀 Features

- `code-server` in the browser (https://code.bramleyvale.com)
- Claude Code installed and ready for use
- Persistent workspace, config, and Claude auth
- Docker + Traefik ready
- Password-based login (via environment variable)

---

## 📁 Volume Layout

| Host Path                               | Purpose                        |
|----------------------------------------|--------------------------------|
| `/home/liam/docker/code-server/workspace` | Project files / workspace      |
| `/home/liam/docker/code-server/config`    | code-server settings           |
| `/home/liam/docker/code-server/claude`    | Claude auth and cache storage  |

---

## 🛠 Usage

### 1. Deploy via Portainer

- Add a new **Git-based stack**
- Set environment variable: `PASSWORD` (for code-server login)
- Deploy

### 2. Log in

Visit: [http://code.bramleyvale.com](http://code.bramleyvale.com)

Use the password you defined via `PASSWORD`.

---

### 3. Authenticate Claude Code

Open the terminal in code-server and run:

```bash
claude
