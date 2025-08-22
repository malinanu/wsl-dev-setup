#!/bin/bash

# WSL Development Environment Setup - Quick Installer
# This script downloads and runs the complete setup automatically

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Configuration
REPO_URL="https://github.com/yourusername/wsl-dev-setup"
BRANCH="main"
INSTALL_DIR="$HOME/wsl-dev-setup"

echo "🚀 WSL Development Environment Setup - Quick Installer"
echo "======================================================"
echo ""
echo "This will install a complete development environment including:"
echo "• Node.js 22 LTS with npm, yarn, pnpm"
echo "• PHP 8.2+ with Composer and extensions"
echo "• Python 3.12 with pip and Poetry"
echo "• MySQL 8.0 database server"
echo "• Nginx (port 80) and Apache (port 8080)"
echo "• Puppeteer for browser automation"
echo "• Project templates and testing tools"
echo ""
echo "📁 Installation directory: $INSTALL_DIR"
echo "🌐 Repository: $REPO_URL"
echo ""

# Check if running in WSL
if [[ ! -f /proc/version ]] || ! grep -q "Microsoft\|WSL" /proc/version; then
    log_error "This installer is designed for WSL (Windows Subsystem for Linux)"
    log_error "Please run this script inside a WSL environment"
    exit 1
fi

log_success "WSL environment detected"

# Check for required tools
log_info "Checking prerequisites..."

if ! command -v git &> /dev/null; then
    log_info "Git not found, installing..."
    sudo apt update
    sudo apt install -y git
fi

if ! command -v curl &> /dev/null; then
    log_info "curl not found, installing..."
    sudo apt update
    sudo apt install -y curl
fi

log_success "Prerequisites check complete"

# Confirm installation
echo ""
read -p "Do you want to continue with the installation? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log_info "Installation cancelled"
    exit 0
fi

# Remove existing installation if present
if [ -d "$INSTALL_DIR" ]; then
    log_warning "Existing installation found at $INSTALL_DIR"
    read -p "Remove existing installation and continue? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$INSTALL_DIR"
        log_info "Existing installation removed"
    else
        log_info "Installation cancelled"
        exit 0
    fi
fi

# Clone repository
log_info "Downloading WSL Development Environment Setup..."
git clone "$REPO_URL" "$INSTALL_DIR"

# Change to installation directory
cd "$INSTALL_DIR"

# Make scripts executable
log_info "Setting up permissions..."
chmod +x setup_dev_env.sh
chmod +x scripts/*.sh 2>/dev/null || true

# Run the main installation
log_info "Starting main installation..."
echo ""
./setup_dev_env.sh

# Installation complete
log_success "Installation completed successfully!"
echo ""
echo "🎉 Your WSL development environment is ready!"
echo "============================================="
echo ""
echo "📋 Next steps:"
echo "1. Reload your environment: source ~/.bashrc"
echo "2. Verify installation: ~/dev-tools/verify-setup.sh"
echo "3. Create your first project:"
echo "   • Next.js: create-next my-app"
echo "   • PHP: create-php my-php-app"  
echo "   • Python: create-python my-python-app"
echo ""
echo "🧪 Test any project with: test-project <project-path>"
echo ""
echo "📚 Documentation: $REPO_URL"
echo "🐛 Issues: $REPO_URL/issues"
echo ""
echo "⭐ If this helped you, please star the repository!"
echo ""
log_info "Installation log saved to: $INSTALL_DIR/install.log"