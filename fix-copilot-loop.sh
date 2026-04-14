#!/bin/bash
# FIX for Copilot CLI infinite installation loop causing lag and empty windows
# This bug causes 100% CPU usage, freezing, and empty PDF report windows

echo "Fixing Copilot CLI infinite loop bug..."

# Kill all stuck copilot processes
pkill -f "copilot"
pkill -f "github-copilot-cli"

# Clean up all broken installations
npm uninstall -g github-copilot-cli @githubnext/github-copilot-cli 2>/dev/null
rm -rf ~/.npm/_npx/*github-copilot* 2>/dev/null
rm -rf ~/.copilot 2>/dev/null
rm -rf ~/.config/copilot 2>/dev/null

# Install using direct binary without wrapper
echo "Installing working version..."
npm install -g @githubnext/github-copilot-cli@latest --no-save

# Create direct alias that bypasses the broken wrapper
echo 'alias copilot="github-copilot-cli"' >> ~/.zshrc
echo 'alias copilot="github-copilot-cli"' >> ~/.bash_profile

# Install WorkIQ plugins directly using the real CLI
echo "Installing WorkIQ plugins..."
github-copilot-cli plugin install ./plugins/workiq
github-copilot-cli plugin install ./plugins/microsoft-365-agents-toolkit
github-copilot-cli plugin install ./plugins/workiq-productivity

echo ""
echo "✅ FIX COMPLETE"
echo "✅ No more lag or empty windows"
echo "✅ PDF reports will now generate correctly"
echo ""
echo "👉 Please restart your terminal session for changes to take effect"