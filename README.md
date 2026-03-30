<div align="center">

# 🚁 Project Fail Mary

### _A multiplayer 3D drone combat game in the browser_

[![Three.js](https://img.shields.io/badge/Three.js-0.118-black?style=for-the-badge&logo=three.js&logoColor=white)](https://threejs.org/)
[![WebAssembly](https://img.shields.io/badge/WebAssembly-654FF0?style=for-the-badge&logo=webassembly&logoColor=white)](https://webassembly.org/)
[![Socket.IO](https://img.shields.io/badge/Socket.IO-4.4-010101?style=for-the-badge&logo=socket.io&logoColor=white)](https://socket.io/)
[![Rust](https://img.shields.io/badge/Rust-WASM-DEA584?style=for-the-badge&logo=rust&logoColor=white)](https://www.rust-lang.org/)
[![Node.js](https://img.shields.io/badge/Node.js-18-339933?style=for-the-badge&logo=node.js&logoColor=white)](https://nodejs.org/)
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](./client/LICENSE)

<br />

**Fly drones • Shoot opponents • Explore procedural terrain**

_Built with Three.js, WebAssembly, WebSockets, and custom GLSL shaders_

[Play Now](#deployment) · [Report Bug](https://github.com/0bVdnt/project-fail-mary/issues) · [Request Feature](https://github.com/0bVdnt/project-fail-mary/issues)

---

<br />

</div>

## 📸 Features

| Feature                     | Description                                                            |
| --------------------------- | ---------------------------------------------------------------------- |
| 🎮 **Multiplayer Combat**   | Real-time drone battles via WebSocket                                  |
| 🏔️ **Procedural Terrain**   | DEM elevation tiles rendered with WebAssembly mesh generation          |
| 🌊 **Dynamic Ocean**        | Flow-mapped water with reflections, refraction, and underwater effects |
| 🌅 **Physically-Based Sky** | Atmospheric scattering with dynamic sun positioning                    |
| 💥 **Particle Effects**     | GPU-accelerated explosions, smoke trails, and bullet tracers           |
| 🎯 **Combat System**        | Gatling guns with hit detection, damage, and respawn                   |
| 📱 **Mobile Support**       | Touch controls with virtual joystick                                   |
| 🤖 **AI Bot**               | Server-side bot opponent for solo play                                 |
| 🎨 **Post-Processing**      | Motion blur, lens flares, underwater distortion, glitch effects        |
| 🔊 **3D Audio**             | Spatial sound for weapons, explosions, and impacts                     |

<br />

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        Browser                              │
│                                                             │
│  ┌──────────────────────────────────────────────────────┐   │
│  │                   Three.js Scene                     │   │
│  │                                                      │   │
│  │  ┌──────────┐  ┌──────────┐  ┌────────────────────┐  │   │
│  │  │ Terrain  │  │  Ocean   │  │  Drone Renderer    │  │   │
│  │  │ Workers  │  │ Shaders  │  │  (GLTF Loader)     │  │   │
│  │  └────┬─────┘  └──────────┘  └────────────────────┘  │   │
│  │       │                                              │   │
│  │  ┌────▼─────┐  ┌──────────┐  ┌────────────────────┐  │   │
│  │  │ WASM     │  │ Particle │  │  Post-Processing   │  │   │
│  │  │ dem2mesh │  │ Engine   │  │  Pipeline          │  │   │
│  │  └──────────┘  └──────────┘  └────────────────────┘  │   │
│  └──────────────────────────────────────────────────────┘   │
│                          │                                  │
│                    Socket.IO Client                         │
└──────────────────────────┬──────────────────────────────────┘
                           │ WebSocket
┌──────────────────────────▼──────────────────────────────────┐
│                     Node.js Server                          │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌────────────────┐     │
│  │   Express    │  │  Socket.IO   │  │   Bot Engine   │     │
│  │   :3001      │  │  Multiplayer │  │   (AI Player)  │     │
│  └──────────────┘  └──────────────┘  └────────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

<br />

## 🛠️ Tech Stack

<table>
<tr>
<td><b>Layer</b></td>
<td><b>Technology</b></td>
<td><b>Purpose</b></td>
</tr>
<tr>
<td>🎨 Rendering</td>
<td>Three.js 0.118</td>
<td>WebGL 3D engine, scene graph, materials</td>
</tr>
<tr>
<td>🌍 Terrain</td>
<td>Rust → WebAssembly</td>
<td>DEM PNG → mesh conversion, mesh simplification (meshopt)</td>
</tr>
<tr>
<td>✨ Shaders</td>
<td>Custom GLSL</td>
<td>Terrain, water, underwater, Oren-Nayar diffuse, voxels</td>
</tr>
<tr>
<td>🧵 Concurrency</td>
<td>Web Workers</td>
<td>Terrain generation and voxel marching cubes off main thread</td>
</tr>
<tr>
<td>🔌 Networking</td>
<td>Socket.IO 4.x</td>
<td>Real-time multiplayer state synchronization</td>
</tr>
<tr>
<td>🖥️ Server</td>
<td>Node.js + Express</td>
<td>Game server, WebSocket relay, bot AI</td>
</tr>
<tr>
<td>📦 Build</td>
<td>Webpack 4 + wasm-pack</td>
<td>Bundle JS/CSS/GLSL/WASM, code splitting, workers</td>
</tr>
<tr>
<td>💥 Particles</td>
<td>ShaderParticleEngine</td>
<td>GPU particle systems for explosions and effects</td>
</tr>
</table>

<br />

## 🎮 Controls

| Key             | Action                                 |
| --------------- | -------------------------------------- |
| `W / A / S / D` | Move forward / left / backward / right |
| `Mouse`         | Look around / aim                      |
| `Left Click`    | Fire gatling gun                       |
| `X`             | Toggle fullscreen                      |
| `Touch`         | Virtual joystick (mobile)              |

<br />

## 📁 Project Structure

```
project-fail-mary/
├── client/                          # Frontend (Three.js app)
│   ├── config/                      # Webpack & build configuration
│   │   └── webpack.config.js        # Build pipeline (JS, GLSL, WASM, Workers)
│   ├── public/                      # Static assets
│   │   └── assets/drone/            # GLTF drone model
│   ├── src/
│   │   ├── index.js                 # App entry — scene, camera, render loop
│   │   ├── controls/                # Fly controls & autopilot
│   │   ├── drones/                  # Drone loading, init, multiplayer sync
│   │   ├── events/                  # PubSub event system
│   │   ├── hud/                     # HUD & crosshair overlay
│   │   ├── loops/                   # Game loops (terrain, voxels, tiles)
│   │   ├── materials/               # Custom GLSL shaders & materials
│   │   ├── modules/                 # Three.js extensions (Sky, FlyControls)
│   │   ├── ocean/                   # Water & underwater shaders
│   │   ├── particles/               # Explosion & smoke particle systems
│   │   ├── postprocessing/          # Motion blur, lens flares, DoF
│   │   ├── sky/                     # Atmospheric sky dome
│   │   ├── socket/                  # Socket.IO client connection
│   │   ├── sound/                   # Spatial audio (OGG files)
│   │   ├── terrain/                 # Terrain system
│   │   │   ├── terrain.worker.js    # Web Worker for terrain generation
│   │   │   └── dem2mesh/            # Rust/WASM crate
│   │   │       ├── Cargo.toml       # Rust dependencies (meshopt, oxipng)
│   │   │       └── src/lib.rs       # PNG→heightmap, mesh simplification
│   │   ├── utils/                   # Helpers, mobile detection
│   │   └── voxel/                   # Voxel system (marching cubes)
│   │       └── voxel.worker.js      # Web Worker for voxel generation
│   └── .env.example                 # Client environment template
│
├── server/                          # Backend (Node.js)
│   ├── index.js                     # Express + Socket.IO server
│   ├── package.json                 # Server dependencies
│   ├── Procfile                     # Heroku/process manager config
│   ├── .env.example                 # Server environment template
│   └── socket-io/
│       ├── main.js                  # Multiplayer event handlers
│       └── bot.js                   # AI bot player
│
├── deploy/                          # Deployment scripts
│   ├── setup.sh                     # EC2 initial setup
│   ├── deploy.sh                    # Build & deploy automation
│   └── nginx.conf                   # Nginx configuration
│
└── README.md
```

<br />

## 🚀 Quick Start (Local Development)

### Prerequisites

- **Node.js** 18.x
- **Rust** toolchain with `wasm32-unknown-unknown` target
- **wasm-pack** 0.10+
- **clang** (for meshopt C++ compilation to WASM)

### 1. Clone the repository

```bash
git clone https://github.com/0bVdnt/project-fail-mary.git
cd project-fail-mary
```

### 2. Build the WASM module

```bash
cd client/src/terrain/dem2mesh
wasm-pack build --target web --release
cd ../../../..
```

### 3. Start the game server

```bash
cd server
cp .env.example .env
npm install
npm run dev
```

### 4. Start the client (new terminal)

```bash
cd client
cp .env.example .env
npm install
export NODE_OPTIONS=--openssl-legacy-provider
npm start
```

Open **http://localhost:3000** — the game should load with terrain, ocean, and a drone.

<br />

## ☁️ AWS EC2 Deployment

Full guide for deploying on a single EC2 instance with Nginx as a reverse proxy.

### Infrastructure

```
┌─────────────────────────────────────────────────┐
│              EC2 Instance (t3.medium)           │
│                                                 │
│   ┌──────────┐     ┌──────────────────────────┐ │
│   │  Nginx   │────▶│  /  → static build files │ │
│   │  :80     │     │  /socket.io → Node :3001 │ │
│   └──────────┘     └──────────────────────────┘ │
│                          │                      │
│                    ┌─────▼─────┐                │
│                    │  Node.js  │                │
│                    │  + PM2    │                │
│                    │  :3001    │                │
│                    └───────────┘                │
└─────────────────────────────────────────────────┘
```

### Step 1 — Launch EC2 Instance

1. Go to **AWS Console → EC2 → Launch Instance**
2. Choose **Ubuntu 22.04 LTS** AMI
3. Instance type: **t3.medium** (2 vCPU, 4GB RAM — needed for Rust/WASM compilation)
4. Configure Security Group:

| Port | Protocol | Source    | Purpose                  |
| ---- | -------- | --------- | ------------------------ |
| 22   | TCP      | Your IP   | SSH access               |
| 80   | TCP      | 0.0.0.0/0 | HTTP traffic             |
| 443  | TCP      | 0.0.0.0/0 | HTTPS traffic (optional) |

5. Launch and connect via SSH:

```bash
ssh -i your-key.pem ubuntu@YOUR_EC2_PUBLIC_IP
```

### Step 2 — Initial Server Setup

```bash
# Switch to root for setup
sudo su

# Download and run the setup script
git clone https://github.com/0bVdnt/project-fail-mary.git /home/ubuntu/app
cd /home/ubuntu/app
chmod +x deploy/setup.sh deploy/deploy.sh
./deploy/setup.sh
```

<details>
<summary>📋 What the setup script installs</summary>

- **Node.js 18** — JavaScript runtime
- **Rust + wasm-pack** — Compiles terrain mesh code to WebAssembly
- **clang + lld + llvm** — C/C++ compiler for meshopt WASM cross-compilation
- **Nginx** — Reverse proxy, serves static files, proxies WebSocket
- **PM2** — Node.js process manager with auto-restart
- **build-essential** — gcc, make, etc.

</details>

### Step 3 — Deploy the Application

```bash
./deploy/deploy.sh
```

<details>
<summary>📋 What the deploy script does</summary>

1. Builds the Rust/WASM module with `wasm-pack`
2. Installs client npm dependencies
3. Builds the client with Webpack (generates static files in `client/build/`)
4. Copies build output to `/var/www/drone-shooter/`
5. Installs server npm dependencies
6. Starts (or restarts) the Node.js game server with PM2

</details>

### Step 4 — Configure Nginx

```bash
# Copy nginx config
sudo cp deploy/nginx.conf /etc/nginx/sites-available/drone-shooter
sudo ln -sf /etc/nginx/sites-available/drone-shooter /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

# Test and reload
sudo nginx -t
sudo systemctl reload nginx
```

### Step 5 — Verify

```bash
# Server status
pm2 status

# Test HTML serving
curl -I http://localhost/
# Should show: Content-Type: text/html

# Test game server
curl -s http://localhost/health
# Should show: ok

# Get your public URL
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
echo "http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 \
  -H "X-aws-ec2-metadata-token: $TOKEN")"
```

Open the URL in your browser 🎮

### Step 6 (Optional) — HTTPS with Let's Encrypt

```bash
# Only if you have a domain pointed to your EC2 IP
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d yourdomain.com
```

### Step 7 — PM2 Auto-Start on Reboot

```bash
pm2 save
pm2 startup
# Run the command PM2 outputs
```

<br />

## 🐛 Troubleshooting

<details>
<summary><b>Build error: <code>error:0308010C:digital envelope routines::unsupported</code></b></summary>

Webpack 4 uses MD4 hashing which is removed in OpenSSL 3 (Node.js 18+).

```bash
export NODE_OPTIONS=--openssl-legacy-provider
npm run build
```

</details>

<details>
<summary><b>Build error: <code>failed to find tool "clang"</code></b></summary>

The meshopt crate requires clang for WASM cross-compilation.

```bash
sudo apt install -y clang lld llvm
```

</details>

<details>
<summary><b>Build error: <code>Module parse failed: parseVec could not cast the value</code></b></summary>

Webpack 4's built-in WASM parser can't handle modern WASM binaries. The fix is to add a file-loader rule for `.wasm` files before the catch-all file-loader in `webpack.config.js`:

```javascript
{
  test: /\.wasm$/,
  type: 'javascript/auto',
  loader: require.resolve('file-loader'),
  options: {
    name: 'static/wasm/[name].[hash:8].[ext]'
  }
},
```

</details>

<details>
<summary><b>Nginx serves files as download (application/octet-stream)</b></summary>

Don't put a `types {}` block at the server level — it overrides all default MIME types. Handle WASM in a separate location block:

```nginx
location ~* \.wasm$ {
    types { application/wasm wasm; }
    default_type application/wasm;
}
```

</details>

<details>
<summary><b>Socket.IO not connecting in production</b></summary>

Ensure `client/src/socket/main.js` uses `window.location.origin` (not a hardcoded IP) and Nginx proxies `/socket.io/` with WebSocket upgrade headers.

</details>

<details>
<summary><b><code>index.html</code> not generated in build</b></summary>

The `HtmlWebpackPartialsPlugin` (analytics) can silently prevent HTML emission. Disable it by setting `ANALYTICS=false` in `.env` or removing it from `webpack.config.js`.

</details>

<br />

## 🔧 Common Operations

```bash
# Redeploy after code changes
cd /home/ubuntu/app && git pull && ./deploy/deploy.sh

# View server logs
pm2 logs drone-server --lines 100

# Restart game server
pm2 restart drone-server

# Monitor resources
pm2 monit

# Check nginx logs
sudo tail -f /var/log/nginx/error.log
```

<br />

## 💰 AWS Cost Estimate

| Resource       | Spec            | Monthly Cost   |
| -------------- | --------------- | -------------- |
| EC2 t3.medium  | 2 vCPU, 4GB RAM | ~$30           |
| EBS (20GB gp3) | Storage         | ~$2            |
| Data transfer  | ~100GB out      | ~$9            |
| **Total**      |                 | **~$41/month** |

> 💡 Use **t3.small** ($15/mo) if you build locally and upload the `client/build/` folder instead of compiling on the instance.

<br />

## 🙏 Credits

- Drone 3D model from [Sketchfab](https://sketchfab.com/) (see `client/public/assets/drone/AUTHOR`)
- Elevation tiles from [Mapzen / AWS Terrain Tiles](https://registry.opendata.aws/terrain-tiles/)
- [dem2mesh](./client/src/terrain/dem2mesh/) WASM crate based on work by Maxime Rouyrre
- Original project by [amankumar321](https://github.com/amankumar321/drone-shooter-3d)
- Water normal maps from Three.js examples

<br />

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](./client/LICENSE) file.

<br />

---

<div align="center">

**[⬆ Back to Top](#-project-fail-mary)**

Made with ☕ and questionable life choices

</div>
