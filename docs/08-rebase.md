# Lesson 8: Rebase

> **Goal:** keep history clean and linear, and tidy up your commits before sharing them.
> Commands: `git rebase`, `git rebase -i`, `git rebase --continue/--abort/--skip`,
> `git commit --fixup`, `git push --force-with-lease`.

---

## 1. Merge vs. rebase: two ways to combine work

Starting point: you branched `feature` from `main`; since then `main` got a new commit `E`.

```
          A ── B ── E          ◀── main
                \
                 C ── D        ◀── feature
```

**Merge** (`git switch feature && git merge main`) ties the lines together with a merge commit:

```
          A ── B ── E ──────┐
                \            \
                 C ── D ──── M  ◀── feature
```

**Rebase** (`git switch feature && git rebase main`) *replays* your commits on top of the new `main`:

```
          A ── B ── E                  ◀── main
                     \
                      C' ── D'         ◀── feature
```

`C'` and `D'` are **new** commits (new hashes) with the same changes as `C` and `D`.
History looks as if you started your work *after* `E`: one straight line.

| | Merge | Rebase |
|-|-------|--------|
| History | True record, with branch/merge shape | Linear, clean |
| Rewrites commits? | No | Yes (new hashes) |
| Safe on shared branches? | ✅ Yes | ❌ Only on your own unshared commits |
| Conflicts | Resolved once | May be resolved once per replayed commit |

Both are fine; teams choose a style. Many use: **rebase your own feature branch to
stay up to date, then merge it into main via a pull request.**

---

## 2. ⚠️ The golden rule of rebasing

> **Never rebase commits that exist outside your repository and that other people
> may have based work on.**

Rebasing replaces commits with new ones. If a teammate already has the old ones,
their history and yours no longer match, and things get messy. Rebase freely on a
branch only you work on.

---

## 3. Basic rebase

```bash
git switch feature
git rebase main
```
```
Successfully rebased and updated refs/heads/feature.
```

Then `main` can fast-forward:
```bash
git switch main
git merge feature        # fast-forward, no merge commit
```

Update your branch with the latest from GitHub in one step:
```bash
git pull --rebase origin main
```

### Rebase conflicts

Rebase applies your commits one by one. If one conflicts, Git pauses:

```
CONFLICT (content): Merge conflict in index.html
error: could not apply c3d4e5f... Add contact form
hint: Resolve all conflicts manually, mark them as resolved with
hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
```

1. Fix the file (same markers as lesson 6). **Note:** during a rebase, "ours"/`HEAD`
   is the branch you're rebasing **onto** (main) and "theirs" is **your** commit
   being replayed. It's the reverse of merge. Confusing, but good to know.
2. `git add <file>`
3. `git rebase --continue` (Git may open an editor for the message; save and close)
4. Repeat until done.

| Command | Meaning |
|---------|---------|
| `git rebase --continue` | Carry on after fixing a conflict |
| `git rebase --skip` | Drop the commit that is currently conflicting |
| `git rebase --abort` | Cancel everything, return to exactly how it was before |

---

## 4. Interactive rebase: edit your history

Interactive rebase lets you **reorder, combine, rename, split or delete** commits.
Perfect for cleaning up "WIP", "fix typo", "oops" commits before opening a pull request.

```bash
git rebase -i HEAD~4       # edit the last 4 commits
```

Your editor opens with a "todo list" (oldest at the **top**, opposite to `git log`):

```
pick a1b2c3d Add search bar
pick b2c3d4e WIP
pick c3d4e5f fix typo in search
pick d4e5f6a Add search tests

# Commands:
# p, pick   = use commit
# r, reword = use commit, but edit the commit message
# e, edit   = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit (combine messages)
# f, fixup  = like "squash", but discard this commit's message
# d, drop   = remove commit
```

Change the words at the start of each line, then save and close:

```
pick a1b2c3d Add search bar
fixup b2c3d4e WIP
fixup c3d4e5f fix typo in search
reword d4e5f6a Add search tests
```

Result: 2 clean commits, "Add search bar" (with the WIP and typo fix merged in)
and the tests commit with a new message you'll be asked to type.

| Action | What it does | Typical use |
|--------|--------------|-------------|
| `pick` | Keep as is | default |
| `reword` | Keep changes, change message | fix a bad message |
| `edit` | Pause at this commit so you can change it (`git commit --amend`, then `git rebase --continue`) | split or modify a commit |
| `squash` | Merge into the commit above, combine messages | combine related commits |
| `fixup` | Merge into the commit above, drop this message | absorb "oops" commits |
| `drop` (or delete the line) | Remove the commit entirely | throw away a bad commit |
| reorder lines | Commits are replayed in the new order | logical ordering |

Other ways to choose the starting point:
```bash
git rebase -i main          # all commits on my branch that aren't on main
git rebase -i a1b2c3d       # all commits after a1b2c3d
git rebase -i --root        # every commit, including the very first
```

### The fixup workflow (pro tip)

```bash
git commit --fixup=a1b2c3d          # make a commit marked "fixup! Add search bar"
git rebase -i --autosquash main     # Git pre-arranges it as a fixup automatically
```

---

## 5. Pushing after a rebase

Your branch's commits were replaced, so a normal `git push` of an already-pushed
branch is rejected ("non-fast-forward"). If it's **your own** feature branch:

```bash
git push --force-with-lease
```

`--force-with-lease` overwrites the remote branch **only if** it still looks the way
you last saw it, so you can't accidentally wipe a teammate's new commits.
Never force-push `main` or any shared branch.

---

## 6. Advanced: `--onto`

Move a branch to start from somewhere else:

```bash
git rebase --onto main old-base feature
# take the commits of feature that come after old-base, and replay them onto main
```

Classic use: you branched `feature-b` off `feature-a` by mistake and want it based on `main`:
`git rebase --onto main feature-a feature-b`.

---

## Summary

| Command | Purpose |
|---------|---------|
| `git rebase <base>` | Replay current branch's commits onto `<base>` |
| `git pull --rebase` | Update from remote, replaying your local commits on top |
| `git rebase -i HEAD~N` | Interactively edit the last N commits |
| `git rebase --continue / --skip / --abort` | Control a rebase in progress |
| `git commit --fixup=<hash>` + `git rebase -i --autosquash` | Auto-arranged fixups |
| `git push --force-with-lease` | Safely update a rebased branch on the remote |
| `git rebase --onto <new> <old> <branch>` | Transplant a branch |

**Next:** [Lab 8](../labs/lab-08-rebase.md), then [Lesson 9: Stash](09-stash.md).
