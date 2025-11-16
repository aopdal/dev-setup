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

echo ""
echo "✅ Post-create setup complete!"
echo ""
