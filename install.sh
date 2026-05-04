#!/bin/bash
# Codex Bug Bounty — install skills into ~/.agents/skills/

set -e

INSTALL_DIR="${HOME}/.agents/skills"
mkdir -p "${INSTALL_DIR}"

echo "Installing Codex Bug Bounty skills..."
echo ""

SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)/.agents/skills"
cp -R "${SOURCE_DIR}"/* "${INSTALL_DIR}/"
echo "✓ Installed skills to ${INSTALL_DIR}"

echo ""
echo "Done! Skills installed to ${INSTALL_DIR}"
echo "Codex command skills installed under ${INSTALL_DIR}/commands"
echo ""

# Offer Burp MCP setup
echo "─────────────────────────────────────────────"
echo "Optional: Burp Suite MCP Integration"
echo "─────────────────────────────────────────────"
echo ""
echo "Connect to PortSwigger's Burp MCP server for live HTTP traffic visibility."
echo "See mcp/burp-mcp-client/README.md for setup instructions."
echo ""
read -p "Set up Burp MCP now? (y/N): " setup_burp
if [[ "$setup_burp" =~ ^[Yy]$ ]]; then
    echo ""
    echo "To connect Burp MCP, add this to your Codex config:"
    echo ""
    echo "  codex config edit"
    echo ""
    echo "Then add to the mcpServers section:"
    cat mcp/burp-mcp-client/config.json | grep -A 10 '"burp"'
    echo ""
    echo "And set your Burp API key:"
    echo "  export BURP_API_KEY=\"your-api-key-here\""
    echo ""
fi

echo "Start hunting:"
echo "  codex"
echo "  \$recon target.com"
echo "  \$hunt target.com"
