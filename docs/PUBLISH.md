# Publishing this bootstrap to GitHub

ChatGPT's standard GitHub connection is read-only. Use the local Mac/OpenCode environment for the actual commit/push.

## Preferred path: OpenCode + local Ollama

1. Put this folder somewhere convenient on the Mac.
2. Open Terminal in the folder.
3. Initialize/link the existing GitHub repository if the folder is not already a clone.
4. Start `opencode`.
5. Because `opencode.json` sets `ollama/qwen3-coder:30b`, routine agent work stays local by default.
6. Ask OpenCode to inspect the files, initialize Git if needed, set the remote to:

   `https://github.com/jukkos/oras-601884vf-home-assistant.git`

   then create the first commit and push to `main`.

Do not add a license until the project owner has chosen one.

## Direct Git alternative

If Git authentication is already configured on the Mac, from this folder:

```bash
git init
git branch -M main
git remote add origin https://github.com/jukkos/oras-601884vf-home-assistant.git
git add .
git commit -m "Bootstrap project documentation and local AI workflow"
git push -u origin main
```

If `origin` already exists, do not add it again. Inspect it with `git remote -v` first.
