#!/bin/bash
set -e

echo "🔧 Running post-create setup..."

# Upgrade pip
echo "📦 Upgrading pip..."
pip install --upgrade pip

# Install Python runtime requirements
if [ -f "requirements.txt" ]; then
    echo "📦 Installing runtime dependencies (aoscx, netbox)..."
    pip install -r requirements.txt
else
    echo "⚠️  requirements.txt not found, skipping..."
fi

# Make LastPass scripts executable
chmod +x .devcontainer/lpass-login.sh
chmod +x .devcontainer/vault-password-file.sh

# Add helper function to bashrc for easy LastPass login
if ! grep -q "lpass-login" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# LastPass helper function" >> ~/.bashrc
    echo "lpass-login() {" >> ~/.bashrc
    echo "    source /workspaces/dev-setup/.devcontainer/lpass-login.sh" >> ~/.bashrc
    echo "}" >> ~/.bashrc
fi

echo ""
echo "✅ Post-create setup complete!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔐 To log in to LastPass and load vault password:"
echo "   Run: lpass-login"
echo "   (or: source .devcontainer/lpass-login.sh)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
