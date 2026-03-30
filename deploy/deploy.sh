#!/bin/bash
set -e

# =============================================
#  Garuda — Deployment Script
# =============================================

PROJECT_DIR="/home/ubuntu/app"
WEB_DIR="/var/www/garuda"
REPO_URL="https://github.com/0bVdnt/garuda.git"

echo "=========================================="
echo "  Garuda — Deploying"
echo "=========================================="

# Source cargo env for wasm-pack
source "$HOME/.cargo/env" 2>/dev/null || true

# ---- Clone or pull ----
echo ""
echo "[1/7] Getting latest code..."
if [ -d "$PROJECT_DIR" ]; then
    cd "$PROJECT_DIR"
    git pull
else
    git clone "$REPO_URL" "$PROJECT_DIR"
    cd "$PROJECT_DIR"
fi

# ---- Build WASM ----
echo ""
echo "[2/7] Building WASM module..."
cd "$PROJECT_DIR/client/src/terrain/dem2mesh"
wasm-pack build --target web --release

# ---- Build Client ----
echo ""
echo "[3/7] Installing client dependencies..."
cd "$PROJECT_DIR/client"

# Create .env if not exists
if [ ! -f .env ]; then
    cp .env.example .env 2>/dev/null || cat >.env <<EOF
REACT_APP_SERVER_URL=
GENERATE_SOURCEMAP=false
ANALYTICS=false
EOF
fi

npm install

echo ""
echo "[4/7] Building client..."
export NODE_OPTIONS=--openssl-legacy-provider
npm run build

# ---- Deploy static files ----
echo ""
echo "[5/7] Deploying static files..."
sudo mkdir -p "$WEB_DIR"
sudo rm -rf "$WEB_DIR"/*
sudo cp -r build/* "$WEB_DIR"/
sudo chown -R www-data:www-data "$WEB_DIR"

# ---- Setup Server ----
echo ""
echo "[6/7] Setting up game server..."
cd "$PROJECT_DIR/server"

if [ ! -f .env ]; then
    cp .env.example .env 2>/dev/null || cat >.env <<EOF
PORT=3001
BOT_SERVER_URL=http://localhost:3001
EOF
fi

npm install --omit=dev

# ---- Start/Restart Server ----
echo ""
echo "[7/7] Starting game server..."
pm2 describe garuda-server >/dev/null 2>&1 &&
    pm2 restart garuda-server ||
    pm2 start index.js --name garuda-server

pm2 save

echo ""
echo "=========================================="
echo "    Deployment complete!"
echo "=========================================="
echo ""
echo "  Verify:"
echo "    pm2 status"
echo "    curl -I http://localhost/"
echo "    curl -s http://localhost/health"
echo ""
