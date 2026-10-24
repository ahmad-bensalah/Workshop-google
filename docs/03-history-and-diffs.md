# Lesson 3: Looking at History and Differences

> **Goal:** see what happened, when, by whom, and exactly what changed.
> Commands: `git log`, `git show`, `git diff`, `git blame`, `git shortlog`.

---

## 1. `git log`: the list of commits

```bash
git log
```
```
commit 7d2e9f1c3b... (HEAD -> main)
Author: Ada Lovelace <ada@example.com>
Date:   Thu Oct 24 10:12:00 2026 +0200

    Add welcome line to README

commit 4a8c0e2... 
Author: Ada Lovelace <ada@example.com>
Date:   Thu Oct 24 10:10:00 2026 +0200

    Add home page

commit 19e3eb1...
Author: Ada Lovelace <ada@example.com>
Date:   Thu Oct 24 10:05:00 2026 +0200

    Add README
```

Newest commits are at the top. `(HEAD -> main)` means: you are on `main`, and
`main` points at this commit.

> The log opens in a **pager** when it is long. Scroll with arrows/Space, press
> `q` to quit.

### The most useful `git log` options

| Command | What it shows |
|---------|---------------|
| `git log --oneline` | One line per commit: short hash + title. Your everyday view. |
| `git log --oneline --graph --all` | A text drawing of all branches and how they join. **Memorise this one.** |
| `git log -n 5` or `git log -5` | Only the last 5 commits |
| `git log -p` | Each commit **with its full diff** (the actual changed lines) |
| `git log --stat` | Each commit with a list of files changed and how many lines |
| `git log --author="Ada"` | Commits by an author (matches part of name or email) |
| `git log --since="2 weeks ago"` | Commits after a date (`--until` for before). Also `"2026-01-01"`, `"yesterday"` |
| `git log --grep="login"` | Commits whose **message** contains "login" |
| `git log -S "password"` | Commits that **added or removed** the text "password" in the code ("pickaxe" search) |
| `git log -- <file>` | Only commits that touched that file |
| `git log --follow -- <file>` | Same, but keeps following the file across renames |
| `git log main..feature` | Commits on `feature` that are **not** on `main` |
| `git log --pretty=format:"%h %an %ar %s"` | Custom format: hash, author, relative date, subject |

Example:
```bash
git log --oneline --graph --all
```
```
* 7d2e9f1 (HEAD -> main) Add welcome line to README
* 4a8c0e2 Add home page
* 19e3eb1 Add README
```

With branches it looks like this (lesson 5):
```
*   e5f6a7b (HEAD -> main) Merge branch 'feature'
|\
| * c3d4e5f (feature) Add contact form
* | b2c3d4e Fix footer
|/
* a1b2c3d Initial commit
```

---

## 2. `git show`: look at one commit

```bash
git show              # the latest commit (HEAD)
git show 4a8c0e2      # a specific commit by hash
git show HEAD~1       # the commit before the latest
git show HEAD:README.md     # the README file as it was in the latest commit
git show 19e3eb1 --stat     # just the list of files changed
```

It prints the commit's details plus its diff.

### Naming commits: hashes, HEAD, `~` and `^`

You can refer to a commit in many ways:

| Name | Means |
|------|-------|
| `7d2e9f1` | The commit with that (short) hash |
| `HEAD` | The commit you are on now |
| `HEAD~1` or `HEAD~` | One commit before HEAD (its parent) |
| `HEAD~3` | Three commits before HEAD |
| `HEAD^2` | The **second parent** of a merge commit (rarely needed) |
| `main` | The commit the `main` branch points to |
| `origin/main` | Where `main` was on the remote, last time you fetched |
| `v1.0` | The commit a tag points to (lesson 10) |
| `main@{yesterday}` | Where `main` pointed yesterday (uses the reflog, lesson 13) |

---

## 3. `git diff`: what exactly changed?

`git diff` compares two versions and prints the lines that differ.

```bash
echo "Contact: ada@example.com" >> README.md
git diff
```
```diff
diff --git a/README.md b/README.md
index 3b18e51..a7c4d02 100644
--- a/README.md
+++ b/README.md
@@ -1,2 +1,3 @@
 # My Website
 Welcome to my site
+Contact: ada@example.com
```

How to read it:
- `--- a/README.md` is the old version, `+++ b/README.md` the new one.
- `@@ -1,2 +1,3 @@`: this chunk ("hunk") starts at line 1; it was 2 lines long, now 3.
- Lines starting with `+` were **added** (green), `-` were **removed** (red),
  a space means unchanged context.

### Which diff do I want?

```
 Working directory ──── git diff ────▶ Staging area ──── git diff --staged ────▶ Last commit
        └────────────────────────── git diff HEAD ──────────────────────────────────┘
```

| Command | Compares |
|---------|----------|
| `git diff` | Working directory vs. staging area: **changes you have not staged yet** |
| `git diff --staged` (same as `--cached`) | Staging area vs. last commit: **what will go into the next commit** |
| `git diff HEAD` | Working directory vs. last commit: **all your uncommitted changes** |
| `git diff <commit1> <commit2>` | Two commits |
| `git diff main feature` | The tips of two branches |
| `git diff main...feature` | What `feature` changed since it split from `main` (what a pull request shows) |
| `git diff HEAD~2 -- README.md` | One file, compared with two commits ago |
| `git diff --stat` | Just a summary of files and line counts |
| `git diff --word-diff` | Highlight changed **words** instead of whole lines (great for text) |
| `git diff --name-only` | Only the names of changed files |

> **Common surprise:** you ran `git add`, then `git diff` shows nothing. That's
> correct! `git diff` only shows *unstaged* changes. Use `git diff --staged`.

**Tip:** a graphical diff tool may be easier to read: `git difftool` opens your
configured tool (for example VS Code: `git config --global diff.tool vscode` and
`git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'`).

---

## 4. `git blame`: who wrote each line?

```bash
git blame README.md
```
```
19e3eb1a (Ada Lovelace 2026-10-24 10:05:00 +0200 1) # My Website
7d2e9f1c (Ada Lovelace 2026-10-24 10:12:00 +0200 2) Welcome to my site
```

For every line: the commit that last changed it, the author, the date, the line
number and the content. Use it to find *why* a line exists: take the hash and run
`git show <hash>`.

| Command | Meaning |
|---------|---------|
| `git blame <file>` | Annotate every line |
| `git blame -L 10,20 <file>` | Only lines 10 to 20 |
| `git blame -w <file>` | Ignore whitespace-only changes |

Despite the name, it's not about blaming people; it's about understanding context.
GitHub shows the same thing with the **Blame** button on any file.

---

## 5. `git shortlog`: who contributed?

```bash
git shortlog -sn       # number of commits per author, sorted
```
```
    42  Ada Lovelace
    17  Alan Turing
```

---

## Summary

| Command | Purpose |
|---------|---------|
| `git log --oneline --graph --all` | Visual history of all branches |
| `git log -p` / `--stat` | History with changes / file summaries |
| `git log --author / --grep / -S / -- <file>` | Search history |
| `git show <commit>` | Details and diff of one commit |
| `git show <commit>:<file>` | A file as it was in a commit |
| `git diff` | Unstaged changes |
| `git diff --staged` | Staged changes |
| `git diff <a> <b>` | Compare commits or branches |
| `git blame <file>` | Who last changed each line |
| `git shortlog -sn` | Commit counts per author |

**Next:** [Lab 3](../labs/lab-03-history.md), then
[Lesson 4: Undoing things](04-undoing-changes.md).
