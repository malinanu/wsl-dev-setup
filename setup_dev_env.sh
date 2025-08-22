#!/bin/bash

# GitHub Repository Setup Script
# This script helps you set up the complete WSL development environment repository

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

echo "📦 GitHub Repository Setup for WSL Development Environment"
echo "========================================================="
echo ""

# Get repository details
read -p "📝 Enter your GitHub username: " GITHUB_USERNAME
read -p "📝 Enter repository name (default: wsl-dev-setup): " REPO_NAME
REPO_NAME=${REPO_NAME:-wsl-dev-setup}

echo ""
log_info "Setting up repository: https://github.com/$GITHUB_USERNAME/$REPO_NAME"

# Create directory structure
log_info "Creating directory structure..."
mkdir -p $REPO_NAME
cd $REPO_NAME

# Create all directories
mkdir -p scripts
mkdir -p .github/workflows
mkdir -p .github/ISSUE_TEMPLATE
mkdir -p docs
mkdir -p templates
mkdir -p examples

log_success "Directory structure created"

# Initialize git repository
log_info "Initializing git repository..."
git init
git branch -M main

# Create .gitignore
cat > .gitignore << 'EOF'
# Logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Coverage directory used by tools like istanbul
coverage/

# nyc test coverage
.nyc_output

# Dependency directories
node_modules/

# Optional npm cache directory
.npm

# Optional REPL history
.node_repl_history

# Output of 'npm pack'
*.tgz

# Yarn Integrity file
.yarn-integrity

# dotenv environment variables file
.env

# IDE files
.vscode/
.idea/
*.swp
*.swo

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Test files
test-screenshot.png
test-result.png

# Backup files
*.backup.*
EOF

log_success "Git repository initialized"

# Create main files
log_info "Creating main files..."

# You'll need to copy the content from the artifacts I created above
echo "📋 Now you need to create these files with the content from the artifacts:"
echo ""
echo "✅ Core Files:"
echo "   • README.md"
echo "   • LICENSE" 
echo "   • CONTRIBUTING.md"
echo "   • CHANGELOG.md"
echo "   • setup_dev_env.sh"
echo "   • install.sh"
echo ""
echo "✅ Scripts Directory:"
echo "   • scripts/fix-npm.sh"
echo "   • scripts/fix-zlib.sh"
echo ""
echo "✅ GitHub Integration:"
echo "   • .github/workflows/test.yml"
echo "   • .github/ISSUE_TEMPLATE/bug_report.md"
echo "   • .github/ISSUE_TEMPLATE/feature_request.md"
echo ""

# Create a helper script to make files executable
cat > make-executable.sh << 'EOF'
#!/bin/bash
echo "Making scripts executable..."
chmod +x setup_dev_env.sh
chmod +x install.sh
chmod +x scripts/*.sh
echo "✅ All scripts are now executable"
EOF

chmod +x make-executable.sh

# Create initial commit template
cat > commit-template.txt << 'EOF'
# Initial commit message template

feat: Initial release of WSL Development Environment Setup

- Add automated installation of Node.js 22 LTS, PHP 8.2+, Python 3.12
- Add MySQL 8.0 database server with development database
- Add Nginx and Apache web servers for production-like testing
- Add Puppeteer browser automation setup
- Add project templates for Next.js, PHP, and Python projects
- Add automated testing tools with test-project command
- Add Claude Code integration support
- Add comprehensive documentation and contribution guidelines
- Add GitHub workflows for automated testing
- Add MIT license for open source distribution

This is the initial release providing a complete development environment
setup for WSL users with one-command installation.
EOF

log_success "Helper files created"

echo ""
echo "🚀 Next Steps:"
echo "=============="
echo ""
echo "1. 📝 Copy content from artifacts to files:"
echo "   • Use the content from each artifact I created"
echo "   • Make sure to update GitHub username in URLs"
echo ""
echo "2. ⚙️  Make scripts executable:"
echo "   ./make-executable.sh"
echo ""
echo "3. 🧪 Test your scripts:"
echo "   bash -n setup_dev_env.sh"
echo "   bash -n scripts/*.sh"
echo ""
echo "4. 📦 Create initial commit:"
echo "   git add ."
echo "   git commit -F commit-template.txt"
echo ""
echo "5. 🌐 Create repository on GitHub:"
echo "   • Go to https://github.com/new"
echo "   • Repository name: $REPO_NAME"
echo "   • Description: Complete WSL development environment setup with one command"
echo "   • Public repository"
echo "   • Don't initialize with README (we have our own)"
echo ""
echo "6. 🔗 Connect and push:"
echo "   git remote add origin https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
echo "   git push -u origin main"
echo ""
echo "7. ⚙️  Configure repository settings:"
echo "   • Enable Issues and Wikis"
echo "   • Add topics: wsl, development, nodejs, php, python, mysql"
echo "   • Add description and website URL"
echo ""
echo "8. 🏷️  Create first release:"
echo "   • Go to Releases → Create a new release"
echo "   • Tag: v1.0.0"
echo "   • Title: Initial Release"
echo "   • Add release notes from CHANGELOG.md"
echo ""
echo "📁 Repository location: $(pwd)"
echo "🌐 Future URL: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo ""
log_success "Repository setup template created!"
echo ""
echo "💡 Pro tip: After pushing, test the quick installer:"
echo "   curl -fsSL https://raw.githubusercontent.com/$GITHUB_USERNAME/$REPO_NAME/main/install.sh | bash"