# Lesson 4: Undoing Things

> **Goal:** fix mistakes safely at every stage.
> Commands: `git restore`, `git commit --amend`, `git reset` (soft / mixed / hard),
> `git revert`, `git clean`, `git rm`, `git mv`, `git checkout <commit> -- <file>`.

This is the lesson that makes Git stop feeling scary. Almost everything is undoable.

---

## 0. The "which undo do I need?" table

| Situation | Command | Safe? |
|-----------|---------|-------|
| I edited a file and want to throw the edits away | `git restore <file>` | ⚠️ edits are lost |
| I staged a file by mistake | `git restore --staged <file>` | ✅ |
| I want a file back as it was N commits ago | `git restore --source=<commit> <file>` | ⚠️ overwrites current file |
| Typo in my last commit message / forgot a file | `git commit --amend` | ✅ if not pushed yet |
| Undo my last commit but keep the changes | `git reset --soft HEAD~1` | ✅ if not pushed yet |
| Throw away my last commit and its changes | `git reset --hard HEAD~1` | ⚠️ if not pushed yet |
| Undo a commit that is **already pushed/shared** | `git revert <commit>` | ✅ always |
| Delete untracked junk files | `git clean -n` then `git clean -f` | ⚠️ files are deleted |
| I did something terrible and want it back | `git reflog` (lesson 13) | ✅ |

> ⚠️ **The one rule:** never rewrite commits that other people already have
> (`reset`, `amend` and `rebase` on pushed commits). Use `revert` instead. If the
> commits are only on your machine, rewrite freely.

---

## 1. Discard changes in the working directory: `git restore`

You edited `index.html`, hated it, want the last committed version back:

```bash
git restore index.html
```

- The file goes back to how it is in the **staging area** (which, if you have not
  staged anything, equals the last commit).
- ⚠️ Your uncommitted edits are **gone for good**: Git never saved them.

```bash
git restore .                  # discard ALL unstaged changes in this folder
```

> Older command you will see in tutorials: `git checkout -- <file>`. Same effect.
> `git restore` was added in Git 2.23 because `checkout` did too many things.

## 2. Unstage: `git restore --staged`

```bash
git add secrets.txt            # oops
git restore --staged secrets.txt
```

The file is no longer staged; your edits remain in the file. Nothing is lost.
(Older equivalent: `git reset HEAD <file>`.)

Both at once (unstage **and** discard edits):
```bash
git restore --staged --worktree <file>
```

## 3. Get an old version of a file

```bash
git restore --source=HEAD~3 index.html     # index.html as it was 3 commits ago
git restore --source=a1b2c3d index.html    # ... or from a specific commit
```

This only changes your working file. Review it, then `add` and `commit` as normal
if you want to keep it. (Older equivalent: `git checkout HEAD~3 -- index.html`.)

---

## 4. Fix the last commit: `git commit --amend`

**Fix the message:**
```bash
git commit --amend -m "Add home page with navigation"
```

**Add a forgotten file to the last commit:**
```bash
git add forgotten.css
git commit --amend --no-edit       # --no-edit keeps the same message
```

`--amend` **replaces** the last commit with a new one (it gets a new hash). If you
had already pushed the old one, pushing will be rejected; that's Git protecting
your teammates. Only amend unpushed commits (or see `--force-with-lease` in lesson 8).

---

## 5. Move the branch backwards: `git reset`

`git reset <commit>` moves the current branch to point at `<commit>`, which
effectively "uncommits" everything after it. The three modes decide what happens to
the changes from those commits:

```
                         Repository    Staging area    Working directory
git reset --soft  HEAD~1   moved          kept            kept
git reset --mixed HEAD~1   moved          reset           kept       ← default
git reset --hard  HEAD~1   moved          reset           reset ⚠️
```

### `--soft`: undo the commit, keep changes **staged**

```bash
git reset --soft HEAD~1
```
Use when: "I committed too early / I want to redo the commit message / I want to
combine the last 3 commits into one" (`git reset --soft HEAD~3` then commit again).

### `--mixed` (default): undo the commit, keep changes **unstaged**

```bash
git reset HEAD~1
```
Use when: "I want to undo the commit and re-pick what to stage."

### `--hard`: undo the commit and **delete** the changes

```bash
git reset --hard HEAD~1
```
Use when: "That last commit was garbage, throw it all away." ⚠️ Also discards any
uncommitted changes in your working directory. Committed work can be recovered
with `git reflog` for a while; uncommitted work cannot.

Other common uses:

```bash
git reset --hard                 # discard ALL uncommitted changes (back to HEAD)
git reset --hard origin/main     # make my main exactly match the remote's main
```

---

## 6. Undo a shared commit safely: `git revert`

`git revert` creates a **new commit that does the opposite** of an old one. History
is not rewritten, so it's safe on commits others already have.

```bash
git revert a1b2c3d
```

Git opens your editor with a message like `Revert "Add buggy feature"`. Save and
close. Now history looks like:

```
* 9f8e7d6 Revert "Add buggy feature"     ← new commit removing the changes
* a1b2c3d Add buggy feature
* ...
```

| Command | Meaning |
|---------|---------|
| `git revert <commit>` | Undo one commit with a new commit |
| `git revert HEAD` | Undo the latest commit |
| `git revert --no-edit <commit>` | Don't open the editor, use the default message |
| `git revert <old>..<new>` | Revert a range of commits (one revert commit each) |
| `git revert -m 1 <merge-commit>` | Revert a merge commit, keeping parent 1 (the branch you merged into) |

If the revert conflicts with later changes, resolve like a merge conflict (lesson 6),
then `git revert --continue` (or `git revert --abort` to give up).

### reset vs. revert

| | `reset` | `revert` |
|-|---------|----------|
| How | Moves the branch back; later commits disappear from the branch | Adds a new "opposite" commit |
| History | Rewritten | Preserved |
| Use on pushed commits? | ❌ No | ✅ Yes |

---

## 7. Delete untracked files: `git clean`

Build output, temp files, test junk... files Git isn't tracking:

```bash
git clean -n       # DRY RUN: list what would be deleted. Always do this first!
git clean -f       # actually delete untracked files (-f = force)
git clean -fd      # also delete untracked folders
git clean -fdx     # also delete IGNORED files (e.g. node_modules). Be careful!
git clean -i       # interactive: choose what to delete
```

⚠️ Deleted untracked files are **not** recoverable through Git. Always run `-n` first.

---

## 8. Delete and rename tracked files: `git rm`, `git mv`

```bash
git rm old-page.html             # delete the file AND stage the deletion
git rm -r old-folder/            # delete a folder
git rm --cached secrets.env      # stop tracking, keep the file on disk
git mv style.css styles.css      # rename (or move) and stage it
git commit -m "Rename stylesheet"
```

If you delete or rename with your file manager instead, that's fine: `git add -A`
(or `git add .`) stages it, and Git detects renames automatically.

---

## Summary

| Command | Purpose |
|---------|---------|
| `git restore <file>` | Discard unstaged edits ⚠️ |
| `git restore --staged <file>` | Unstage |
| `git restore --source=<commit> <file>` | Bring back an old version of a file |
| `git commit --amend` | Rewrite the last commit (message or content) |
| `git reset --soft HEAD~1` | Uncommit, keep changes staged |
| `git reset HEAD~1` | Uncommit, keep changes unstaged |
| `git reset --hard HEAD~1` | Uncommit and discard changes ⚠️ |
| `git revert <commit>` | Safely undo a shared commit |
| `git clean -n` / `-f` / `-fd` | Preview / delete untracked files |
| `git rm`, `git mv` | Delete / rename tracked files |

**Next:** [Lab 4](../labs/lab-04-undo.md), then [Lesson 5: Branches](05-branching.md).
