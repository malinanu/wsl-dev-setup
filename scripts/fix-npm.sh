#!/bin/bash

# Fix npm configuration conflicts
# This script resolves npm/nvm configuration issues that can occur
# when there are existing npm or nvm installations

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

echo "🔧 Fixing npm configuration conflicts..."
echo "======================================="

# Stop any running npm processes
log_info "Stopping npm processes..."
pkill -f npm 2>/dev/null || true
sleep 2

# Remove conflicting npm configurations
log_info "Cleaning npm configurations..."
rm -f ~/.npmrc
rm -rf ~/.npm-global
rm -rf ~/.npm/_cacache 2>/dev/null || true

# Clean npm cache
if command -v npm &> /dev/null; then
    log_info "Cleaning npm cache..."
    npm cache clean --force 2>/dev/null || true
fi

# Remove nvm if present (it might conflict)
log_info "Removing nvm if present..."
rm -rf ~/.nvm
export NVM_DIR=""
unset NVM_DIR

# Clean bashrc from npm/nvm entries
if [ -f ~/.bashrc ]; then
    log_info "Cleaning .bashrc..."
    cp ~/.bashrc ~/.bashrc.backup.$(date +%Y%m%d_%H%M%S)
    sed -i '/npm-global/d' ~/.bashrc
    sed -i '/NVM_DIR/d' ~/.bashrc
    sed -i '/nvm.sh/d' ~/.bashrc
    sed -i '/nvm bash_completion/d' ~/.bashrc
fi

# Remove any global npm packages that might cause conflicts
log_info "Removing conflicting global packages..."
sudo rm -rf /usr/local/lib/node_modules 2>/dev/null || true
sudo rm -rf /usr/local/bin/npm 2>/dev/null || true
sudo rm -rf /usr/local/bin/npx 2>/dev/null || true

# Reset npm to defaults
if command -v npm &> /dev/null; then
    log_info "Resetting npm configuration..."
    npm config delete prefix 2>/dev/null || true
    npm config delete globalconfig 2>/dev/null || true
    npm config delete cache 2>/dev/null || true
    
    log_info "Current npm configuration:"
    npm config list 2>/dev/null || log_warning "npm not available yet"
fi

log_success "npm configuration cleaned!"
echo ""
echo "🚀 Next steps:"
echo "1. Re-run the main setup script: ./setup_dev_env.sh"
echo "2. Or continue with manual installation"
echo ""
echo "📝 Note: The main script will create a fresh, clean npm configuration."
echo "📋 A backup of your .bashrc was created: ~/.bashrc.backup.*"