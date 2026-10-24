# Lesson 13: Power Tools

> **Goal:** rescue lost work, move single commits around, hunt bugs through
> history, and know the advanced tools exist.
> Commands: `git reflog`, `git cherry-pick`, `git bisect`, `git worktree`,
> `git submodule`, `git grep`, `git archive`, hooks, `git gc`, `git fsck`.

---

## 1. `git reflog`: Git's undo history (your safety net)

Every time HEAD moves (commit, switch, reset, rebase, merge, amend...), Git writes
it down in the **reflog**. It's local, private, and kept for ~90 days by default.

```bash
git reflog
```
```
7d2e9f1 (HEAD -> main) HEAD@{0}: reset: moving to HEAD~2
c3d4e5f HEAD@{1}: commit: Add contact form
b2c3d4e HEAD@{2}: commit: Add footer
7d2e9f1 HEAD@{3}: checkout: moving from feature to main
```

### Rescue recipes

**"I did `git reset --hard` and lost commits!"**
```bash
git reflog                      # find the line BEFORE the reset, e.g. HEAD@{1}
git reset --hard HEAD@{1}       # go back there
```

**"I deleted a branch with `-D`!"**
```bash
git reflog                      # find the last commit of that branch
git branch recovered c3d4e5f    # recreate a branch pointing at it
```

**"A rebase went wrong!"**
```bash
git reflog                      # find "rebase (start)" and pick the entry just below it
git reset --hard HEAD@{5}
# Shortcut right after a rebase: git reset --hard ORIG_HEAD
```

| Command | Meaning |
|---------|---------|
| `git reflog` | HEAD's movement history |
| `git reflog show <branch>` | A branch's movement history |
| `git log -g` | Reflog in full `log` format |
| `HEAD@{2}` | Where HEAD was 2 moves ago |
| `main@{1.hour.ago}` | Where main was an hour ago |

> The reflog can only save work that was **committed** at some point. Commit often!

---

## 2. `git cherry-pick`: copy a single commit

Take one commit from another branch and apply it here (as a new commit):

```bash
git switch main
git cherry-pick a1b2c3d
```

```
feature:  A ── B ── X ── C          (X is a bug fix you need on main now)
main:     A ── D ── X'              (X' = copy of X)
```

| Command | Meaning |
|---------|---------|
| `git cherry-pick <commit>` | Copy one commit onto the current branch |
| `git cherry-pick <c1> <c2>` | Copy several |
| `git cherry-pick <a>..<b>` | Copy a range (excluding `a`) |
| `git cherry-pick -n <commit>` | Apply the changes but don't commit (`--no-commit`) |
| `git cherry-pick -x <commit>` | Add "(cherry picked from commit ...)" to the message |
| `git cherry-pick --continue / --abort / --skip` | After a conflict |

Typical uses: backport a fix to a release branch; rescue one good commit from an
abandoned branch; you committed to the wrong branch.

**"I committed to main instead of a feature branch":**
```bash
git switch -c feature          # new branch keeps the commit
git switch main
git reset --hard HEAD~1        # remove it from main (only if not pushed!)
```

---

## 3. `git bisect`: find which commit introduced a bug

You know the app worked at `v1.0` and is broken now, with 200 commits in between.
`bisect` does a **binary search**: at most ~8 tests instead of 200.

```bash
git bisect start
git bisect bad                  # the current commit is broken
git bisect good v1.0            # this old one was fine
# Git checks out a commit in the middle. Test it, then tell Git:
git bisect good                 # if this commit works
git bisect bad                  # if it's broken
# ... repeat until Git prints:
#   a1b2c3d is the first bad commit
git bisect reset                # return to where you started
```

**Automate it** with a script that exits 0 for good and non-zero for bad:

```bash
git bisect start HEAD v1.0
git bisect run npm test         # or: ./check.sh, pytest, make test ...
git bisect reset
```

`git bisect skip` skips a commit you can't test. `git bisect log` shows your answers.

---

## 4. `git worktree`: two branches checked out at once

Need to fix a bug on `main` while a long build runs on your feature branch? Instead
of stashing, check out another branch in a **second folder** sharing the same repo:

```bash
git worktree add ../hotfix-folder main      # main is now checked out in ../hotfix-folder
cd ../hotfix-folder
# ... fix, commit, push ...
cd -
git worktree list
git worktree remove ../hotfix-folder
```

A branch can only be checked out in one worktree at a time.

---

## 5. `git submodule`: a repo inside a repo

Include another Git repository at a fixed commit (e.g. a shared library):

```bash
git submodule add https://github.com/them/lib.git libs/lib
git commit -m "Add lib as submodule"

# When cloning a project that has submodules:
git clone --recurse-submodules <url>
# or, after a normal clone:
git submodule update --init --recursive

# Update submodules to the latest commit of their tracked branch:
git submodule update --remote
```

Submodules are powerful but confusing; many teams prefer package managers
(npm, pip, Maven...) instead. Know they exist.

---

## 6. Searching and exporting

```bash
git grep "TODO"                    # search tracked files (fast, respects .gitignore)
git grep -n "login" -- "*.js"      # with line numbers, only .js files
git grep "TODO" v1.0               # search the code as it was at tag v1.0

git archive --format=zip -o site.zip HEAD    # export a snapshot without the .git folder
```

## 7. Hooks: run scripts automatically

Hooks are scripts in `.git/hooks/` that Git runs at certain moments:

| Hook | When | Example use |
|------|------|-------------|
| `pre-commit` | Before a commit is created | Run linter/formatter; block if it fails |
| `commit-msg` | After you write the message | Enforce Conventional Commits |
| `pre-push` | Before pushing | Run tests |
| `post-merge` | After a merge/pull | Reinstall dependencies |

Example `.git/hooks/pre-commit` (make it executable with `chmod +x`):
```bash
#!/bin/sh
if git diff --cached | grep -q "console.log"; then
  echo "❌ Remove console.log before committing"
  exit 1
fi
```

Hooks in `.git/hooks` aren't shared through push. Teams use tools like
[pre-commit](https://pre-commit.com) or [Husky](https://typicode.github.io/husky/),
or `git config core.hooksPath .githooks` with a committed `.githooks/` folder.
Skip hooks once with `git commit --no-verify` (use sparingly).

## 8. Housekeeping

```bash
git gc               # garbage-collect: compress and clean up the repository
git fsck             # check the repository for corruption / find dangling commits
git count-objects -vH   # how big is the repo?
git maintenance start   # schedule background optimisation
```

## 9. Rewriting large parts of history

Need to remove a file (e.g. a leaked secret or huge file) from **every** commit?
Use [`git filter-repo`](https://github.com/newren/git-filter-repo) (the modern
replacement for `git filter-branch`) or [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/):

```bash
git filter-repo --path secrets.env --invert-paths
```

This rewrites all commit hashes: everyone must re-clone, and you must force-push.
**Rotate the secret anyway**: assume it was already copied.

---

## Summary

| Command | Purpose |
|---------|---------|
| `git reflog` | Find "lost" commits; undo resets/rebases |
| `git cherry-pick <commit>` | Copy one commit to the current branch |
| `git bisect start/good/bad/run/reset` | Binary-search for a bug's origin |
| `git worktree add <path> <branch>` | Second working folder for the same repo |
| `git submodule add/update` | Embed another repo |
| `git grep` | Search tracked code |
| `git archive` | Export a snapshot |
| `.git/hooks/*` | Automate checks |
| `git gc` / `git fsck` | Maintenance |
| `git filter-repo` | Remove files from all history |

**Next:** [Lab 11](../labs/lab-11-rescue.md), and keep
[Lesson 14: Troubleshooting](14-troubleshooting.md) bookmarked.
