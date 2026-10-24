# Lesson 5: Branches

> **Goal:** work on several things in parallel without them interfering.
> Commands: `git branch`, `git switch`, `git checkout`, detached HEAD.

---

## 1. What a branch really is

A branch is just a **named pointer to a commit**. It's tiny (a 41-byte file in
`.git/refs/heads/`), so creating one is instant and free.

```
main:     A ── B ── C
                    ▲
                   main
                    ▲
                   HEAD
```

When you create a branch `feature`, Git makes a second pointer at the same commit:

```
main:     A ── B ── C   ◀── main, feature
```

Switch to `feature` and commit: only `feature` moves forward.

```
          A ── B ── C   ◀── main
                     \
                      D ◀── feature ◀── HEAD
```

Meanwhile someone commits on `main`; the lines diverge:

```
          A ── B ── C ── E   ◀── main
                     \
                      D ◀── feature
```

Later you **merge** them back together (lesson 6).

**Why branch?**
- Keep `main` always working, deployable and clean.
- Work on a feature for days without breaking anything.
- Try a risky experiment; if it fails, just delete the branch.
- Several people can each work on their own branch at the same time.

---

## 2. List branches: `git branch`

```bash
git branch
```
```
  feature
* main
```

The `*` marks the branch you're on.

| Command | Shows |
|---------|-------|
| `git branch` | Local branches |
| `git branch -v` | ... with the last commit of each |
| `git branch -r` | Remote branches (lesson 7) |
| `git branch -a` | All branches, local and remote |
| `git branch --merged` | Branches already merged into the current one (safe to delete) |
| `git branch --no-merged` | Branches with work not yet merged |
| `git branch --show-current` | Just the name of the current branch |

---

## 3. Create and switch: `git switch`

```bash
git switch -c feature-contact      # create a branch AND switch to it (-c = create)
```
```
Switched to a new branch 'feature-contact'
```

Other forms:

| Command | Meaning |
|---------|---------|
| `git switch <branch>` | Switch to an existing branch |
| `git switch -c <new>` | Create a new branch from where you are, and switch |
| `git switch -c <new> <start>` | Create a new branch starting at `<start>` (a branch, tag or hash) |
| `git switch -` | Switch back to the previous branch (like the TV "last channel" button) |
| `git branch <new>` | Create a branch but **stay** where you are |

### The older way: `git checkout`

You will see `checkout` everywhere in older tutorials and Stack Overflow answers:

| Old | New equivalent |
|-----|----------------|
| `git checkout <branch>` | `git switch <branch>` |
| `git checkout -b <new>` | `git switch -c <new>` |
| `git checkout -- <file>` | `git restore <file>` |
| `git checkout <commit> -- <file>` | `git restore --source=<commit> <file>` |

Both work. This workshop uses `switch`/`restore` because each does one clear job.

### What happens to my files when I switch?

Git rewrites the files in your working directory to match the branch you switch to.
Files that differ between branches change before your eyes in the editor. That's
expected.

If you have **uncommitted changes** that would be overwritten, Git refuses:
```
error: Your local changes to the following files would be overwritten by checkout:
	index.html
Please commit your changes or stash them before you switch branches.
```
Options: commit them, stash them (lesson 9), or discard them (`git restore`).
Uncommitted changes that don't conflict simply come along with you to the new branch.

---

## 4. A full example

```bash
git switch -c feature-contact
echo "<form>Contact me</form>" > contact.html
git add contact.html
git commit -m "Add contact page"

git switch main          # contact.html disappears from the folder! (it only exists on the branch)
ls
git switch feature-contact   # ... and it's back
git log --oneline --graph --all
```
```
* 5c6d7e8 (HEAD -> feature-contact) Add contact page
* 7d2e9f1 (main) Add welcome line to README
* 4a8c0e2 Add home page
* 19e3eb1 Add README
```

---

## 5. Rename and delete branches

```bash
git branch -m <old> <new>     # rename a branch (-m = move)
git branch -m <new>           # rename the current branch
git branch -M main            # force-rename current branch to main (used when publishing a new repo)

git branch -d <branch>        # delete a branch that has been merged (safe)
git branch -D <branch>        # force-delete, even if NOT merged ⚠️ (its commits become unreachable)
```

You cannot delete the branch you're currently on; switch away first.
Deleting a branch deletes only the **label**, not the commits that are already
merged elsewhere. Unmerged commits can still be rescued with `git reflog` for a
while (lesson 13).

Delete a branch on GitHub: `git push origin --delete <branch>` (lesson 7).

---

## 6. Detached HEAD (don't panic)

If you switch to a **commit** or **tag** instead of a branch:

```bash
git switch --detach a1b2c3d     # or the old: git checkout a1b2c3d
```
```
HEAD is now at a1b2c3d Add README
```
`git status` says `HEAD detached at a1b2c3d`.

**What it means:** HEAD points directly to a commit, not to a branch. You can look
around, run the code, even make commits, but those commits belong to no branch,
and if you switch away they are easy to lose.

**How to get out:**
- Just looking? `git switch main` (or `git switch -`).
- Made commits you want to keep? Give them a branch **before** leaving:
  `git switch -c rescue-branch`.

---

## 7. Branch naming conventions

Pick a convention with your team. Common ones:

```
feature/user-login
fix/cart-total-rounding
docs/installation-guide
chore/upgrade-dependencies
ada/experiment-dark-mode
```

Use lowercase, hyphens, no spaces. Slashes are allowed and many tools group them as folders.

---

## Summary

| Command | Purpose |
|---------|---------|
| `git branch` (`-v`, `-a`, `--merged`) | List branches |
| `git switch -c <name>` | Create and switch |
| `git switch <name>` / `git switch -` | Switch / switch back |
| `git branch -m <new>` | Rename current branch |
| `git branch -d <name>` / `-D` | Delete merged / force delete |
| `git switch --detach <commit>` | Look at an old commit (detached HEAD) |
| `git checkout ...` | Older all-in-one command for switching and restoring |

**Next:** [Lab 5](../labs/lab-05-branches.md), then
[Lesson 6: Merging and conflicts](06-merging-and-conflicts.md).
