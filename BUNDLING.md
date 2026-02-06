# Bundling for a lightweight GitHub repo

If you want to upload a repo without the `node_modules` folder, create a single bundled server file and commit that instead.

1. Build the bundle (on your development machine):

```bash
npx @vercel/ncc build server.js -o dist
```

2. Run the bundle on the target machine (Node must be installed):

```bash
node dist/index.js
```

Notes:
- `yt-dlp` and `ffmpeg` still need to be present on the host.
- `.gitignore` excludes `node_modules/` and `/dist` by default; remove `/dist` from `.gitignore` if you want to commit the bundle.
