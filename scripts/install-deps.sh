#!/bin/sh
set -e

if [ "${SKIP_MP3_TUBER_DEPS:-}" = "1" ]; then
  exit 0
fi

OS=$(uname -s 2>/dev/null || echo "")
if [ "$OS" != "Linux" ]; then
  exit 0
fi

command -v ffmpeg >/dev/null 2>&1 && HAVE_FFMPEG=1 || HAVE_FFMPEG=0
command -v yt-dlp >/dev/null 2>&1 && HAVE_YTDLP=1 || HAVE_YTDLP=0

if [ "$HAVE_FFMPEG" -eq 1 ] && [ "$HAVE_YTDLP" -eq 1 ]; then
  exit 0
fi

if command -v apt-get >/dev/null 2>&1; then
  APT_TMP=/tmp/apt
  mkdir -p "$APT_TMP/lists" "$APT_TMP/cache"
  apt-get -o Dir::State::lists="$APT_TMP/lists" -o Dir::Cache::archives="$APT_TMP/cache" update
  apt-get -o Dir::State::lists="$APT_TMP/lists" -o Dir::Cache::archives="$APT_TMP/cache" install -y ffmpeg curl

  if ! command -v yt-dlp >/dev/null 2>&1; then
    curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
    chmod a+rx /usr/local/bin/yt-dlp
  fi
else
  echo "WARN: apt-get not available; please install ffmpeg and yt-dlp manually."
fi
