#!/bin/bash
# LastPass login helper script
# NOTE: This script must be sourced, not executed directly
# Usage: source .devcontainer/lpass-login.sh
#    or: lpass-login (if the function is in your .bashrc)

echo "🔐 LastPass Login"
echo ""

# Check if already logged in
if lpass status -q 2>/dev/null; then
    echo "✅ Already logged in to LastPass"
    CURRENT_USER=$(lpass status | grep -oP 'Logged in as \K[^.]+')
    echo "   User: $CURRENT_USER"
else
    echo "Please enter your LastPass email:"
    read -r LPASS_EMAIL
    
    echo ""
    echo "Logging in to LastPass..."
    if lpass login "$LPASS_EMAIL"; then
        echo "✅ Successfully logged in to LastPass"
    else
        echo "❌ Failed to log in to LastPass"
        return 1
    fi
fi

echo ""
echo "🔑 Setting up vault password file..."

# Test that we can retrieve the vault password
if lpass show vault-password -p &>/dev/null; then
    export ANSIBLE_VAULT_PASSWORD_FILE="/workspaces/dev-setup/.devcontainer/vault-password-file.sh"
    echo "✅ Vault password file configured"
    echo ""
    echo "💡 ANSIBLE_VAULT_PASSWORD_FILE is now set."
    echo "   Ansible will automatically use it - no need to specify --vault-password-file!"
else
    echo "❌ Failed to retrieve vault-password from LastPass"
    echo "   Make sure the 'vault-password' entry exists in your vault"
    return 1
fi
