# Lesson 12: .gitignore, Aliases and Useful Configuration

> **Goal:** keep junk and secrets out of your repo, and make Git faster to use.
> Commands: `.gitignore`, `git check-ignore`, `git config alias.*`, `.gitattributes`, `git lfs`.

---

## 1. `.gitignore`: files Git should never track

Create a file literally named `.gitignore` in the root of the repo and commit it.
Each line is a pattern:

```gitignore
# Comments start with #

# A specific file
.env

# Every file with this extension, anywhere
*.log
*.tmp

# A folder (trailing slash = directories only), anywhere in the repo
node_modules/
__pycache__/
dist/
build/

# Only in the root (leading slash)
/config.local.json

# Any depth with **
**/coverage/

# Exception: track this one even though *.log is ignored (leading !)
!important.log

# OS and editor junk
.DS_Store
Thumbs.db
.vscode/
.idea/
```

| Pattern | Matches |
|---------|---------|
| `file.txt` | `file.txt` in any folder |
| `/file.txt` | only `file.txt` at the repo root |
| `*.log` | any `.log` file |
| `logs/` | any folder named `logs` and everything inside |
| `docs/*.pdf` | PDFs directly in `docs/` (not subfolders) |
| `docs/**/*.pdf` | PDFs anywhere under `docs/` |
| `!keep.log` | re-include a file excluded by an earlier pattern |

**Ready-made templates** for every language: <https://github.com/github/gitignore>
or <https://www.toptal.com/developers/gitignore>. GitHub also offers one when you create a repo.

### Already tracked? `.gitignore` won't help (yet)

`.gitignore` only affects **untracked** files. If you already committed a file:

```bash
git rm --cached <file>          # or: git rm -r --cached <folder>
git commit -m "Stop tracking <file>"
```

### Why is this file ignored?

```bash
git check-ignore -v <file>
```
```
.gitignore:3:*.log	debug.log
```
(file `.gitignore`, line 3, pattern `*.log`).

`git status --ignored` lists ignored files.

### Other ignore files

| File | Scope | Shared with team? |
|------|-------|-------------------|
| `.gitignore` (any folder) | That folder and below | ✅ committed |
| `.git/info/exclude` | This clone only | ❌ |
| Global: `git config --global core.excludesFile ~/.gitignore_global` | All your repos | ❌ (good for `.DS_Store`, editor files) |

### Never commit secrets

Passwords, API keys, tokens, private keys, `.env` files. Put them in `.gitignore`
**before** the first commit. Commit a `.env.example` with fake values instead so
others know which variables they need. If you leak one, see lesson 14.

---

## 2. Aliases: your own shortcuts

```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.sw switch
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage "restore --staged"
git config --global alias.last "log -1 HEAD --stat"
git config --global alias.lg "log --oneline --graph --all --decorate"
git config --global alias.undo "reset --soft HEAD~1"
```

Now `git st` = `git status`, `git lg` draws the graph, `git undo` uncommits the
last commit keeping its changes.

Aliases are stored in `~/.gitconfig`; you can also edit that file directly:

```ini
[user]
    name = Ada Lovelace
    email = ada@example.com
[init]
    defaultBranch = main
[alias]
    st = status
    lg = log --oneline --graph --all --decorate
```

---

## 3. Settings worth knowing

| Setting | Command | Why |
|---------|---------|-----|
| Default branch | `git config --global init.defaultBranch main` | Modern default |
| Editor | `git config --global core.editor "code --wait"` | Pick your editor |
| Pull behaviour | `git config --global pull.rebase false` (or `true`) | Required before pulling divergent branches; choose merge/rebase |
| Auto set upstream | `git config --global push.autoSetupRemote true` | `git push` on a new branch works without `-u` |
| Prune on fetch | `git config --global fetch.prune true` | Forget deleted remote branches automatically |
| Better conflicts | `git config --global merge.conflictstyle zdiff3` | Show original text in conflicts |
| Reuse resolutions | `git config --global rerere.enabled true` | Git remembers how you solved a conflict and reuses it |
| Autocorrect typos | `git config --global help.autocorrect 20` | `git stauts` runs `status` after 2 seconds |
| Sort branches | `git config --global branch.sort -committerdate` | Most recent branches first |
| Credential cache | `git config --global credential.helper cache` | Remember HTTPS credentials for 15 min (Linux) |

## 4. Line endings (Windows vs. Mac/Linux)

Windows ends lines with `CRLF`, macOS/Linux with `LF`. Mixed teams can get
"every line changed" diffs.

```bash
# Windows
git config --global core.autocrlf true
# macOS / Linux
git config --global core.autocrlf input
```

Better: commit a `.gitattributes` file so everyone gets the same behaviour:

```gitattributes
* text=auto
*.sh text eol=lf
*.bat text eol=crlf
*.png binary
```

## 5. Large files: Git LFS

Git stores every version of every file forever, so big binaries (videos, datasets,
design files) bloat the repo. GitHub blocks files over 100 MB. Use **Git LFS**
(Large File Storage):

```bash
git lfs install                  # once per machine
git lfs track "*.psd"            # store .psd files in LFS (writes to .gitattributes)
git add .gitattributes
git add design.psd
git commit -m "Add design file via LFS"
```

## 6. Signing commits (optional)

Prove commits really came from you (GitHub shows a **Verified** badge). The simplest
way uses your SSH key:

```bash
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true
```
Then add the same public key on GitHub as a **Signing key** (Settings → SSH and GPG keys).

---

## Summary

| Command / file | Purpose |
|----------------|---------|
| `.gitignore` | Patterns of files to never track |
| `git rm --cached <file>` | Untrack a file that's now ignored |
| `git check-ignore -v <file>` | Explain why a file is ignored |
| `git config --global alias.<name> "<cmd>"` | Create a shortcut |
| `.gitattributes` | Line endings, binary files, LFS |
| `git lfs track "<pattern>"` | Store big files outside normal history |

**Next:** [Lesson 13: Power tools](13-power-tools.md).
