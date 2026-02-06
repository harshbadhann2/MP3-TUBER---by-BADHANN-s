# 🎵 MP3-Tuber

**™ HARSH BADHAN**

[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org/)
[![License](https://img.shields.io/badge/license-Not%20Specified-red.svg)]()
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)]()

> A lightweight, self-hosted web application that converts YouTube videos into high-quality MP3 files. Perfect for personal use with content you own or have permission to download.

---

## 📋 Table of Contents

- [Features](#-features)
- [Demo](#-demo)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Usage](#-usage)
- [API Reference](#-api-reference)
- [Project Structure](#-project-structure)
- [Security & Legal](#-security--legal)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [Contact](#-contact)

---

## ✨ Features

- 🎯 **Simple Conversion** — Convert individual YouTube videos to MP3 (no playlists)
- 🎧 **High-Quality Audio** — Extract audio using `yt-dlp` and `ffmpeg`
- 🧹 **Auto Cleanup** — Temporary storage with automatic file expiration (1 hour)
- 🚀 **Lightweight** — Minimal Express server with clean web UI
- 📊 **Diagnostics** — Built-in dependency checker
- 🔒 **Privacy-Focused** — Self-hosted solution, your data stays with you

---

## 🎬 Demo

1. **Enter YouTube URL** → Paste the video link
2. **Confirm Rights** → Check the box to confirm you have permission
3. **Convert** → Click the button and wait for processing
4. **Download** → Get your MP3 file!

```
┌─────────────────────────────────────┐
│  Paste YouTube URL                  │
├─────────────────────────────────────┤
│  ☑ I confirm I have the rights     │
├─────────────────────────────────────┤
│       [Convert to MP3]              │
└─────────────────────────────────────┘
         ↓
    Processing...
         ↓
   [Download MP3] 🎵
```

---

## 🔧 Prerequisites

Before you begin, ensure you have the following installed:

| Requirement | Version | Check Command |
|------------|---------|---------------|
| **Node.js** | 18+ | `node --version` |
| **yt-dlp** | Latest | `yt-dlp --version` |
| **ffmpeg** | Latest | `ffmpeg -version` |

### Installation Guide

#### macOS (recommended)
```bash
brew install yt-dlp ffmpeg
```

#### Linux (Ubuntu/Debian)
```bash
# Install yt-dlp
sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
sudo chmod a+rx /usr/local/bin/yt-dlp

# Install ffmpeg
sudo apt update
sudo apt install ffmpeg
```

#### Windows
```bash
# Using Chocolatey
choco install yt-dlp ffmpeg

# Or using Scoop
scoop install yt-dlp ffmpeg
```

#### Alternative: Install yt-dlp via pipx
```bash
pipx install yt-dlp
```

---

## 🚀 Installation

### Quick Start

```bash
# Clone the repository
git clone https://github.com/harshbadhann2/MP3-Tuber.git
cd MP3-Tuber

# Install dependencies
npm install

# Run in development mode (default port: 3030)
PORT=3030 npm run dev
```

### Custom Port

```bash
# Run on a different port
PORT=8080 npm start
```

### Access the Application

Open your browser and navigate to:
```
http://localhost:3030
```

---

## 💻 Usage

### Web Interface

1. Open the application in your browser
2. Paste a YouTube video URL
3. Check "I confirm I have rights to download this content"
4. Click "Convert to MP3"
5. Wait for processing (usually 10-30 seconds)
6. Click "Download" when ready

### Command Line (via API)

```bash
# Start a conversion
curl -X POST http://localhost:3030/api/convert \
  -H "Content-Type: application/json" \
  -d '{"url":"https://youtube.com/watch?v=VIDEO_ID","rightsConfirmed":true}'

# Response: {"jobId":"abc123"}

# Check status
curl http://localhost:3030/api/status/abc123

# Download the file
curl -O http://localhost:3030/api/download/abc123
```

---

## 📚 API Reference

### Endpoints

#### `POST /api/convert`
Start a new conversion job.

**Request Body:**
```json
{
  "url": "https://youtube.com/watch?v=VIDEO_ID",
  "rightsConfirmed": true
}
```

**Response:**
```json
{
  "jobId": "unique-job-id-123"
}
```

---

#### `GET /api/status/:id`
Check the status of a conversion job.

**Response (Processing):**
```json
{
  "status": "processing",
  "progress": 45
}
```

**Response (Completed):**
```json
{
  "status": "completed",
  "downloadUrl": "/api/download/unique-job-id-123",
  "filename": "Video Title.mp3"
}
```

**Response (Failed):**
```json
{
  "status": "failed",
  "error": "Error message here"
}
```

---

#### `GET /api/download/:id`
Download the converted MP3 file.

**Response:** Binary MP3 file stream

---

#### `GET /api/diagnostics`
Check if required dependencies are installed.

**Response:**
```json
{
  "ytdlp": {
    "available": true,
    "version": "2024.01.01"
  },
  "ffmpeg": {
    "available": true,
    "version": "6.0"
  }
}
```

---

## 📁 Project Structure

```
MP3-Tuber/
├── server.js           # Express server & conversion logic
├── package.json        # Dependencies & scripts
├── public/             # Static web UI files
│   ├── index.html      # Main web interface
│   ├── app.js          # Client-side JavaScript
│   └── styles.css      # Styling
├── downloads/          # Temporary MP3 storage (auto-cleanup)
└── README.md           # You are here!
```

---

## 🔒 Security & Legal

### ⚠️ Important Disclaimers

- **Legal Use Only:** Only convert content you own or have explicit permission to download
- **No DRM Bypass:** This tool does not circumvent DRM or content protection measures
- **Temporary Storage:** MP3 files are automatically deleted after 1 hour
- **Privacy:** All processing happens on your local machine—no data sent to third parties

### Rights Confirmation

By using this tool, you confirm that:
- ✅ You own the content or have permission to download it
- ✅ You will use the downloaded content in compliance with applicable laws
- ✅ You understand this tool is for personal, non-commercial use

---

## 🐛 Troubleshooting

### Common Issues

<details>
<summary><b>Conversion fails immediately</b></summary>

**Solution:**
1. Visit `/api/diagnostics` endpoint
2. Verify `yt-dlp` and `ffmpeg` are installed:
   ```bash
   yt-dlp --version
   ffmpeg -version
   ```
3. Ensure both are in your system PATH
</details>

<details>
<summary><b>"Module not found" errors</b></summary>

**Solution:**
```bash
# Delete node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
```
</details>

<details>
<summary><b>Port already in use</b></summary>

**Solution:**
```bash
# Use a different port
PORT=8080 npm run dev

# Or kill the process using port 3030
lsof -ti:3030 | xargs kill -9
```
</details>

<details>
<summary><b>Downloads folder fills up</b></summary>

**Solution:**
Auto-cleanup runs every hour. To manually clear:
```bash
rm -rf downloads/*
```
</details>

### Still Having Issues?

- Check server logs in your terminal where you ran `npm run dev`
- Ensure your Node.js version is 18 or higher: `node --version`
- Try updating dependencies: `npm update`
- Open an issue on [GitHub](https://github.com/harshbadhann2/MP3-Tuber/issues)

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** your changes (`git commit -m 'Add some AmazingFeature'`)
4. **Push** to the branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

### Contribution Guidelines

- Keep changes focused and atomic
- Include tests when adding new features
- Follow existing code style
- Update documentation as needed
- Be respectful and constructive

---

## 📜 License & Trademark

- **License:** This repository does not currently include a software license. Please contact the owner before using or redistributing.
- **Trademark:** MP3 Tuber™ is a trademark of **HARSH BADHAN**

---

## 📞 Contact

- **Repository:** [github.com/harshbadhann2/MP3-Tuber](https://github.com/harshbadhann2/MP3-Tuber)
- **Issues:** [Report a Bug](https://github.com/harshbadhann2/MP3-Tuber/issues)
- **Owner:** HARSH BADHAN

---

## 🌟 Show Your Support

If you find this project useful, please consider:
- ⭐ Starring the repository
- 🐛 Reporting bugs
- 💡 Suggesting new features
- 🔀 Contributing code

---

<div align="center">

**Enjoy converting your videos! 🎵**

Made with ❤️ by HARSH BADHAN

</div>
