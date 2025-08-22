#!/bin/bash

# Fix zlib stream errors and package system issues
# This script resolves common apt package download and decompression errors

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

echo "🔧 Fixing zlib stream errors and package system issues..."
echo "======================================================="

# Check disk space first
log_info "Checking disk space..."
AVAILABLE_SPACE=$(df /tmp | tail -1 | awk '{print $4}')
if [ "$AVAILABLE_SPACE" -lt 1000000 ]; then
    log_warning "Low disk space detected. Consider freeing up some space."
    df -h
fi

# Stop all apt processes that might be running
log_info "Stopping conflicting apt processes..."
sudo killall apt apt-get dpkg 2>/dev/null || true
sudo killall packagekit 2>/dev/null || true

# Wait for processes to terminate
sleep 3

# Fix dpkg locks if they exist
log_info "Removing dpkg locks..."
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/lib/dpkg/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/apt/lists/lock

# Clean all apt cache and corrupted packages
log_info "Cleaning apt cache and corrupted packages..."
sudo apt clean
sudo apt autoclean
sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /var/cache/apt/archives/partial/*

# Reconfigure dpkg to fix any broken packages
log_info "Reconfiguring package system..."
sudo dpkg --configure -a

# Fix any broken dependencies
log_info "Fixing broken dependencies..."
sudo apt --fix-broken install -y

# Update package lists with verbose output for debugging
log_info "Updating package lists..."
sudo apt update

# Test package system with a simple package
log_info "Testing package system..."
if sudo apt install -y curl wget; then
    log_success "Package system is working correctly!"
else
    log_error "Package system still has issues"
    
    # Additional troubleshooting
    log_info "Trying alternative package sources..."
    
    # Change to main Ubuntu sources if needed
    if [ -f /etc/apt/sources.list ]; then
        sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
        log_info "Backup created: /etc/apt/sources.list.backup"
    fi
    
    # Try different mirror
    log_info "You may need to change to a different Ubuntu mirror"
    log_info "Edit /etc/apt/sources.list or run: sudo apt edit-sources"
    
    exit 1
fi

# Verify internet connectivity
log_info "Testing internet connectivity..."
if ping -c 1 google.com &> /dev/null; then
    log_success "Internet connectivity is working"
else
    log_warning "Internet connectivity issues detected"
    log_info "Please check your network connection"
fi

# Check for common WSL issues
log_info "Checking WSL-specific issues..."
if grep -q "Microsoft\|WSL" /proc/version 2>/dev/null; then
    log_info "Running in WSL environment"
    
    # Check for common WSL DNS issues
    if [ ! -f /etc/resolv.conf ] || [ ! -s /etc/resolv.conf ]; then
        log_warning "DNS configuration issues detected"
        log_info "You may need to restart WSL: wsl --shutdown (from Windows)"
    fi
else
    log_info "Not running in WSL environment"
fi

log_success "Package system diagnostics complete!"
echo ""
echo "🚀 Next steps:"
echo "1. Re-run the main setup script: ./setup_dev_env.sh"
echo "2. If issues persist, try:"
echo "   - Restart WSL: wsl --shutdown (from Windows Command Prompt)"
echo "   - Check internet connection"
echo "   - Try different Ubuntu mirror: sudo apt edit-sources"
echo ""
echo "📋 System Information:"
echo "   - WSL Distribution: $(lsb_release -d 2>/dev/null | cut -f2 || echo 'Unknown')"
echo "   - Available disk space: $(df -h /tmp | tail -1 | awk '{print $4}')"
echo "   - Memory usage: $(free -h | grep Mem | awk '{print $3 "/" $2}')"