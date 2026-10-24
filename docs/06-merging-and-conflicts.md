# Lesson 6: Merging and Resolving Conflicts

> **Goal:** bring work from one branch into another, and calmly fix conflicts.
> Commands: `git merge`, `git merge --abort`, `git merge --no-ff`, `git merge --squash`,
> `git mergetool`, `git checkout --ours/--theirs`.

---

## 1. The basic merge

You always merge **into the branch you are on**. So: switch to the receiving
branch, then name the branch to bring in.

```bash
git switch main          # 1. go to the branch that RECEIVES the work
git merge feature        # 2. bring feature's commits into main
```

Read it as: *"merge feature into the current branch"*.

There are two kinds of merges, and Git picks automatically.

### Fast-forward merge

If `main` has **not moved** since `feature` branched off, Git just slides the
`main` pointer forward. No new commit is created.

```
Before:   A ── B          ◀── main
                \
                 C ── D   ◀── feature

After:    A ── B ── C ── D   ◀── main, feature
```

Output:
```
Updating 723c982..ac0a799
Fast-forward
 index.html | 1 +
 1 file changed, 1 insertion(+)
```

### Three-way merge (merge commit)

If **both** branches have new commits, Git combines them and creates a new
**merge commit** with two parents.

```
Before:   A ── B ── E        ◀── main
                \
                 C ── D      ◀── feature

After:    A ── B ── E ────── M   ◀── main
                \           /
                 C ── D ───┘     ◀── feature
```

Git opens your editor with a default message `Merge branch 'feature'`. Save and
close (or use `git merge feature --no-edit`).

### Useful merge options

| Command | Meaning |
|---------|---------|
| `git merge <branch>` | Merge (fast-forward if possible) |
| `git merge --no-ff <branch>` | Always create a merge commit, even if fast-forward is possible. Keeps a visible record that a feature branch existed. |
| `git merge --ff-only <branch>` | Only merge if it can fast-forward, otherwise refuse. Safe for updating. |
| `git merge --squash <branch>` | Combine all of the branch's changes into **staged** changes; you then `git commit` once. Produces one tidy commit, no merge commit. |
| `git merge --no-edit <branch>` | Accept the default merge message |
| `git merge --abort` | Cancel a merge in progress and go back to how things were |

After merging, you can delete the feature branch: `git branch -d feature`.

---

## 2. Merge conflicts

A **conflict** happens when both branches changed **the same lines** of the same
file (or one deleted a file the other changed). Git can't guess which version you
want, so it stops and asks you.

Conflicts are **normal**. They are not errors and nothing is broken.

### Step 1: Git tells you

```bash
git merge blue
```
```
Auto-merging index.html
CONFLICT (content): Merge conflict in index.html
Automatic merge failed; fix conflicts and then commit the result.
```

### Step 2: see which files conflict

```bash
git status
```
```
On branch main
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Unmerged paths:
  (use "git add <file>..." to mark resolution)
	both modified:   index.html
```

### Step 3: open the file and read the conflict markers

```
<<<<<<< HEAD
<h1>Hello and welcome</h1>
=======
<h1>Welcome to my blue site</h1>
>>>>>>> blue
<p>footer</p>
```

| Marker | Meaning |
|--------|---------|
| `<<<<<<< HEAD` | Start of **your** version (the branch you are on, here `main`) |
| `=======` | Divider |
| `>>>>>>> blue` | End of **their** version (the branch you are merging in) |

Everything outside the markers merged fine.

### Step 4: edit the file to the final version you want

Delete the markers and keep what makes sense: yours, theirs, or a mix of both.

```html
<h1>Hello and welcome to my blue site</h1>
<p>footer</p>
```

Make sure **no** `<<<<<<<`, `=======` or `>>>>>>>` lines remain. Search for them!
`git diff --check` warns about leftover markers.

> **Editors help a lot.** VS Code shows clickable buttons above each conflict:
> *Accept Current Change*, *Accept Incoming Change*, *Accept Both Changes*.

### Step 5: mark as resolved and finish

```bash
git add index.html        # "add" = "I resolved this file"
git status                # all conflicts fixed? "All conflicts fixed but you are still merging."
git commit                # finish the merge (message is pre-filled; save and close)
```

(`git merge --continue` does the same as `git commit` here.)

### Changed your mind?

```bash
git merge --abort         # everything goes back to before you ran git merge
```

---

## 3. Shortcuts for picking a whole side

If you know you want one side for an entire file:

```bash
git checkout --ours   index.html     # keep the version from your current branch
git checkout --theirs index.html     # keep the version from the branch being merged
git add index.html
```

(Also available as `git restore --ours <file>` / `git restore --theirs <file>`.)

Merge with a strategy that prefers one side for **every** conflicting hunk:

```bash
git merge -X ours feature      # on conflicts, prefer my side
git merge -X theirs feature    # on conflicts, prefer their side
```

Use these carefully: you might silently drop someone's work.

## 4. Graphical merge tools

```bash
git mergetool
```

opens a visual three-pane tool for each conflicted file. Configure one, e.g. VS Code:

```bash
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait --merge $REMOTE $LOCAL $BASE $MERGED'
```

Tip: `git config --global merge.conflictstyle zdiff3` adds a third section to the
conflict markers showing the **original** text before either side changed it.
This makes conflicts much easier to understand.

---

## 5. How to avoid painful conflicts

- **Merge or pull often.** Small, frequent merges = small conflicts.
- **Keep branches short-lived** (days, not months).
- **Make small, focused commits.**
- **Talk to your team** when you're both editing the same file.
- **Don't reformat whole files** in the same commit as real changes.

---

## Summary

| Command | Purpose |
|---------|---------|
| `git merge <branch>` | Merge `<branch>` into the current branch |
| `git merge --no-ff` / `--ff-only` / `--squash` | Control how the merge is recorded |
| `git merge --abort` | Cancel a conflicted merge |
| `git status` | See conflicted files ("both modified") |
| edit file, then `git add <file>` | Mark a conflict resolved |
| `git commit` or `git merge --continue` | Finish the merge |
| `git checkout --ours/--theirs <file>` | Take one side for a whole file |
| `git mergetool` | Resolve with a visual tool |
| `git diff --check` | Find leftover conflict markers |

**Next:** [Lab 6](../labs/lab-06-conflicts.md), then
[Lesson 7: Remotes and GitHub](07-remotes-and-github.md).
