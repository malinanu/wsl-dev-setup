# WSL Development Environment Setup

🚀 **Complete development environment setup for WSL (Windows Subsystem for Linux) with one command!**

Automatically installs and configures Node.js, PHP, Python, MySQL, Apache, Nginx, and browser testing tools for seamless web development in WSL.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![WSL Compatible](https://img.shields.io/badge/WSL-Compatible-blue.svg)](https://docs.microsoft.com/en-us/windows/wsl/)
[![Tested on Ubuntu](https://img.shields.io/badge/Tested%20on-Ubuntu%2020.04%2B-orange.svg)](https://ubuntu.com/)

## ✨ Features

- **🟢 Node.js 22 LTS** with npm, yarn, pnpm, and popular tools
- **🐘 PHP 8.2+** with Composer and essential extensions  
- **🐍 Python 3.12** with pip, venv, and Poetry
- **🗄️ MySQL 8.0** with development database pre-configured
- **🌐 Nginx** (port 80) for production-like testing
- **⚡ Apache** (port 8080) for cPanel-like environments
- **🤖 Puppeteer** ready for headless browser testing
- **🧪 Automated testing tools** for all project types
- **📦 Project templates** for quick scaffolding
- **🔧 Claude Code integration** ready

## 🎯 Perfect For

- **Web developers** using WSL for local development
- **Full-stack projects** with multiple technologies
- **Teams** wanting consistent development environments
- **Claude Code users** needing automated testing
- **Developers** deploying to cPanel/cloud hosting

## 🚀 Quick Start

### Prerequisites

- Windows 10/11 with WSL2 enabled
- Ubuntu 20.04+ or similar Debian-based WSL distribution
- At least 4GB free disk space
- Internet connection

### One-Command Installation

```bash
# Clone and run
git clone https://github.com/yourusername/wsl-dev-setup.git
cd wsl-dev-setup
chmod +x setup_dev_env.sh
./setup_dev_env.sh
```

### Alternative: Direct Download

```bash
# Download and run directly
curl -fsSL https://raw.githubusercontent.com/yourusername/wsl-dev-setup/main/setup_dev_env.sh -o setup_dev_env.sh
chmod +x setup_dev_env.sh
./setup_dev_env.sh
```

## 📋 What Gets Installed

| Technology | Version | Purpose |
|------------|---------|---------|
| Node.js | 22 LTS | JavaScript runtime + npm ecosystem |
| PHP | 8.2+ | Server-side scripting + modern features |
| Python | 3.12 | Latest Python with modern syntax |
| MySQL | 8.0 | Database server |
| Nginx | Latest | Production web server (port 80) |
| Apache | Latest | Alternative web server (port 8080) |
| Chromium | Latest | Headless browser testing |
| Composer | Latest | PHP package manager |
| Poetry | Latest | Python package manager |

## 🛠️ Post-Installation Usage

### Activate Environment
```bash
source ~/.bashrc
~/dev-tools/verify-setup.sh
```

### Create Projects
```bash
# Next.js project
create-next my-awesome-app

# PHP project  
create-php my-php-project

# Python project
create-python my-python-app
```

### Test Projects
```bash
# Auto-detect project type and test
test-project /path/to/project

# Test with specific port
test-project /path/to/project 3000

# Test with specific server type
test-project /path/to/project 3000 node
```

### Access Your Applications

| Service | URL | Use Case |
|---------|-----|----------|
| Nginx | http://localhost | Production-like testing |
| Apache | http://localhost:8080 | cPanel-like testing |
| Node.js apps | http://localhost:3000 | Development server |
| PHP apps | http://localhost:8000 | Built-in PHP server |
| Python apps | http://localhost:5000 | Flask/FastAPI apps |

## 🧪 Testing Features

### Automated Browser Testing
The setup includes Puppeteer for automated testing:

```bash
# Test any web application
test-project /path/to/your/project

# The test will:
# ✅ Start your application
# ✅ Test it with Puppeteer  
# ✅ Take a screenshot
# ✅ Report results
# ✅ Clean up processes
```

### Project Type Detection
Automatically detects and handles:
- **Node.js** projects (package.json)
- **PHP** projects (index.php, composer.json)
- **Python** projects (app.py, main.py)

### Claude Code Integration
Perfect for Claude Code users:
```bash
# Claude Code can run this command to test builds
test-project $(pwd) 3000 node
```

## 📁 Directory Structure

After installation, you'll have:

```
~/
├── dev-tools/           # Testing and utility scripts
│   ├── test-app.js     # Main testing script
│   ├── verify-setup.sh # Environment verification
│   └── package.json    # Dependencies
├── dev-templates/       # Project templates
│   ├── create-nextjs.sh
│   ├── create-php.sh
│   └── create-python.sh
└── python-projects/     # Python projects directory
```

## 🔧 Troubleshooting

### Common Issues

**npm configuration conflicts:**
```bash
./scripts/fix-npm.sh
```

**Package download errors:**
```bash
./scripts/fix-zlib.sh
```

**Permission issues:**
```bash
sudo chown -R $USER:$USER ~/dev-tools
```

**MySQL connection issues:**
```bash
sudo systemctl restart mysql
mysql -u dev_user -p dev_database
# Password: dev_password
```

### Verification Commands

```bash
# Check all services
~/dev-tools/verify-setup.sh

# Check individual services
systemctl status nginx
systemctl status apache2  
systemctl status mysql
node --version
php --version
python3 --version
```

## 🎛️ Configuration

### Default Database Settings
- **Database:** `dev_database`
- **Username:** `dev_user` 
- **Password:** `dev_password`
- **Host:** `localhost:3306`

### Web Server Ports
- **Nginx:** 80 (production-like)
- **Apache:** 8080 (cPanel-like)
- **Node.js:** 3000 (development)
- **PHP built-in:** 8000
- **Python apps:** 5000

### Customization
Edit these files to customize:
- **Nginx config:** `/etc/nginx/sites-available/dev-default`
- **Apache config:** `/etc/apache2/sites-available/000-default.conf`
- **PHP config:** `/etc/php/8.2/fpm/php.ini`
- **MySQL config:** `/etc/mysql/mysql.conf.d/mysqld.cnf`

## 🤝 Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Development Setup
```bash
git clone https://github.com/yourusername/wsl-dev-setup.git
cd wsl-dev-setup
# Make your changes
./test/run-tests.sh  # Run tests
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built for developers using WSL for web development
- Optimized for Claude Code integration
- Inspired by the need for consistent development environments

## 📈 Roadmap

- [ ] Docker integration support
- [ ] Additional language support (Go, Rust, Java)
- [ ] VS Code integration
- [ ] Database alternatives (PostgreSQL, MongoDB)
- [ ] SSL/HTTPS setup automation
- [ ] Performance optimization tools

---

**⭐ If this helped you, please give it a star!**

Made with ❤️ for the WSL development community.