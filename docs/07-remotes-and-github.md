# Lesson 7: Remotes and GitHub

> **Goal:** connect your repository to GitHub, upload (push) and download
> (fetch/pull) work, and authenticate securely.
> Commands: `git clone`, `git remote`, `git push`, `git fetch`, `git pull`,
> `git branch -u`, `ssh-keygen`.

---

## 1. What is a remote?

A **remote** is a named link to another copy of the repository, usually on
GitHub, GitLab or Bitbucket. The default name is **`origin`**.

```
  Your computer                               GitHub
 ┌───────────────────────┐   git push    ┌──────────────────┐
 │ main  ── A─B─C─D      │ ────────────▶ │ main ── A─B─C─D  │
 │ origin/main ── A─B─C  │ ◀──────────── │                  │
 └───────────────────────┘ fetch / pull  └──────────────────┘
```

`origin/main` is a **remote-tracking branch**: your local, read-only memory of
where `main` was on GitHub the last time you talked to it. It only updates when
you `fetch`, `pull` or `push`.

---

## 2. Create a GitHub account and authenticate

1. Sign up at <https://github.com>.
2. Choose how your computer proves who you are. GitHub no longer accepts your
   account password for Git. Use **one** of:

### Option A (recommended): SSH keys

An SSH key is a pair of files: a **private** key that stays on your computer (never
share it!) and a **public** key you give to GitHub.

```bash
# 1. Check whether you already have a key
ls ~/.ssh
# If you see id_ed25519 and id_ed25519.pub, skip to step 3.

# 2. Generate a new key (press Enter to accept the default location;
#    choose a passphrase or leave it empty)
ssh-keygen -t ed25519 -C "ada@example.com"

# 3. Start the SSH agent and add your key (so you don't type the passphrase every time)
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# 4. Print the PUBLIC key and copy the whole line
cat ~/.ssh/id_ed25519.pub
```

5. On GitHub: **Settings → SSH and GPG keys → New SSH key**, paste, save.
6. Test the connection:

```bash
ssh -T git@github.com
```
```
Hi ada! You've successfully authenticated, but GitHub does not provide shell access.
```

(The first time, type `yes` to trust GitHub's host fingerprint.)

### Option B: HTTPS with a Personal Access Token or GitHub CLI

- **GitHub CLI** (easiest): install from <https://cli.github.com>, run `gh auth login`,
  follow the prompts. It configures Git for you.
- **Token**: GitHub → *Settings → Developer settings → Personal access tokens*.
  Create a token with `repo` access. When Git asks for a password, paste the
  token. On Windows/macOS, Git's credential manager remembers it.

URLs look different depending on the method:

| Method | URL format |
|--------|-----------|
| SSH | `git@github.com:ada/my-website.git` |
| HTTPS | `https://github.com/ada/my-website.git` |

---

## 3. `git clone`: download an existing repository

```bash
git clone git@github.com:ada/my-website.git
cd my-website
```

`clone` does all of this for you:
1. Creates a folder named after the repo.
2. Downloads the **entire history**.
3. Adds a remote called `origin` pointing at the URL.
4. Checks out the default branch (usually `main`) and sets it to track `origin/main`.

| Command | Meaning |
|---------|---------|
| `git clone <url>` | Clone into a folder named after the repo |
| `git clone <url> <folder>` | Clone into a folder with your chosen name |
| `git clone --depth 1 <url>` | "Shallow" clone: only the latest commit (fast, for big repos) |
| `git clone -b <branch> <url>` | Clone and check out a specific branch |

---

## 4. `git remote`: manage remote links

```bash
git remote -v
```
```
origin  git@github.com:ada/my-website.git (fetch)
origin  git@github.com:ada/my-website.git (push)
```

| Command | Meaning |
|---------|---------|
| `git remote` | List remote names |
| `git remote -v` | List remotes with URLs |
| `git remote add <name> <url>` | Add a remote |
| `git remote remove <name>` | Remove a remote |
| `git remote rename <old> <new>` | Rename a remote |
| `git remote set-url <name> <new-url>` | Change a remote's URL (e.g. switch HTTPS → SSH) |
| `git remote show origin` | Detailed info: branches, tracking, what's out of date |
| `git remote prune origin` | Remove remote-tracking branches deleted on the server |

---

## 5. Publish a local repository on GitHub

You already have a local repo with commits (from lessons 2–6).

1. On GitHub click **New repository**. Name it `my-website`. **Do not** tick
   "Add a README", ".gitignore" or "license" (the repo must be empty, otherwise
   your first push is rejected because histories differ).
2. Copy the SSH URL and run:

```bash
git remote add origin git@github.com:ada/my-website.git
git branch -M main          # make sure your branch is called main
git push -u origin main
```

Refresh the GitHub page: your files and history are there. 🎉

---

## 6. `git push`: upload your commits

```bash
git push -u origin main     # first time for a branch
git push                    # afterwards
```

- `origin` = which remote, `main` = which branch.
- `-u` (`--set-upstream`) links your local `main` to `origin/main`. After that, a
  bare `git push` or `git pull` knows where to go.

| Command | Meaning |
|---------|---------|
| `git push` | Push the current branch to its upstream |
| `git push -u origin <branch>` | Push a new branch and set its upstream |
| `git push origin <branch>` | Push a specific branch |
| `git push origin --delete <branch>` | Delete a branch on the remote |
| `git push --tags` | Push all tags (lesson 10) |
| `git push --force-with-lease` | Overwrite the remote branch after rewriting history, **but only if nobody else pushed** in the meantime (lesson 8) |
| `git push --force` | Overwrite the remote branch no matter what ⚠️ can destroy teammates' work. Prefer `--force-with-lease`. |

### "Rejected"? Pull first

```
 ! [rejected]        main -> main (fetch first)
error: failed to push some refs to 'github.com:ada/my-website.git'
hint: Updates were rejected because the remote contains work that you do not
hint: have locally.
```

Someone (maybe you, from another computer or via GitHub's web editor) pushed
commits you don't have. Get them first, then push:

```bash
git pull
git push
```

---

## 7. `git fetch`: download without changing your work

```bash
git fetch            # download new commits/branches from origin
git fetch --all      # from every remote
git fetch --prune    # also forget remote branches that were deleted
```

`fetch` updates `origin/main` etc., but **does not touch** your local branches or
files. It is always safe. Then you can inspect before merging:

```bash
git log --oneline main..origin/main    # commits on GitHub I don't have yet
git diff main origin/main              # what they change
git merge origin/main                  # bring them in when ready
```

## 8. `git pull`: fetch + integrate

```bash
git pull
```

`git pull` = `git fetch` + `git merge origin/<current-branch>`.

| Command | Meaning |
|---------|---------|
| `git pull` | Fetch and merge (may create a merge commit) |
| `git pull --rebase` | Fetch and **rebase** your local commits on top (cleaner, linear history; lesson 8) |
| `git pull --ff-only` | Only update if it's a simple fast-forward; otherwise stop and let you decide |
| `git pull origin <branch>` | Pull a specific branch |

Pick a default once. If you haven't, Git stops with `fatal: Need to specify how to
reconcile divergent branches` the first time both sides have new commits:
```bash
git config --global pull.rebase false   # merge (default, simplest)
git config --global pull.rebase true    # rebase
git config --global pull.ff only        # only fast-forward
```

If `pull` produces a conflict, resolve it exactly as in lesson 6.

> **Tip:** commit or stash your work **before** pulling. Pulling into a dirty
> working directory can stop halfway.

---

## 9. Tracking branches

A local branch can "track" a remote branch. `git status` then tells you how they compare:

```
On branch main
Your branch is ahead of 'origin/main' by 2 commits.
  (use "git push" to publish your local commits)
```

| Message | Meaning | Do |
|---------|---------|----|
| `up to date with 'origin/main'` | Same (as of last fetch) | nothing |
| `ahead of 'origin/main' by 2 commits` | You have unpushed commits | `git push` |
| `behind 'origin/main' by 3 commits` | GitHub has new commits | `git pull` |
| `have diverged` | Both have new commits | `git pull` (merge or rebase), then `git push` |

```bash
git branch -vv                           # show each branch's upstream and ahead/behind
git branch -u origin/main                # set upstream of current branch
git switch <branch>                      # if only origin/<branch> exists, Git creates a
                                         # local tracking branch automatically
```

---

## Summary

| Command | Purpose |
|---------|---------|
| `ssh-keygen -t ed25519 -C "<email>"` | Create an SSH key |
| `ssh -T git@github.com` | Test GitHub SSH access |
| `git clone <url>` | Copy a remote repository |
| `git remote -v` / `add` / `set-url` / `remove` | Manage remotes |
| `git push -u origin <branch>` | First push of a branch |
| `git push` | Upload commits |
| `git push origin --delete <branch>` | Delete a remote branch |
| `git fetch` | Download without merging (safe) |
| `git pull` / `git pull --rebase` | Download and integrate |
| `git branch -vv` | See tracking info |

**Next:** [Lab 7](../labs/lab-07-github.md), then [Lesson 8: Rebase](08-rebase.md).
