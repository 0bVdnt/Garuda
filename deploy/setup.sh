#!/bin/bash
set -e

echo "=========================================="
echo "  Project Fail Mary — Server Setup"
echo "=========================================="

echo ""
echo "[1/6] Updating system..."
sudo apt update && sudo apt upgrade -y

echo ""
echo "[2/6] Installing Node.js 18..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

echo ""
echo "[3/6] Installing Rust + wasm-pack..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
rustup target add wasm32-unknown-unknown
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

echo ""
echo "[4/6] Installing build tools..."
sudo apt install -y build-essential pkg-config libssl-dev git clang lld llvm nginx
sudo npm install -g pm2

echo ""
echo "[5/6] Verifying installations..."
echo "  Node.js : $(node --version)"
echo "  npm     : $(npm --version)"
echo "  Rust    : $(rustc --version)"
echo "  wasm-pack: $(wasm-pack --version)"
echo "  Nginx   : $(nginx -v 2>&1)"
echo "  PM2     : $(pm2 --version)"
echo "  Clang   : $(clang --version | head -1)"

echo ""
echo "[6/6] Setup complete!"
echo "  Run ./deploy/deploy.sh to deploy the application."
