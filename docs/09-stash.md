# Lesson 9: Stash: Put Work Aside for a Moment

> **Goal:** save unfinished changes without committing, so you can switch tasks.
> Commands: `git stash`, `git stash list`, `git stash pop`, `git stash apply`,
> `git stash drop`, `git stash show`, `git stash branch`.

---

## 1. The situation

You're halfway through a feature. Your boss: *"Urgent bug on main, fix it now!"*
Your changes aren't ready to commit, and `git switch main` refuses because they
would be overwritten. **Stash** them:

```bash
git stash                 # save changes and clean the working directory
git switch main
# ... fix the bug, commit, push ...
git switch feature
git stash pop             # get your unfinished work back
```

Think of the stash as a **stack of drawers**: `stash` puts your mess in a drawer,
`pop` takes it out again.

---

## 2. Stash commands

| Command | Meaning |
|---------|---------|
| `git stash` | Stash modified **tracked** files (staged and unstaged) |
| `git stash push -m "<message>"` | Stash with a description (recommended) |
| `git stash -u` | Also stash **untracked** (new) files |
| `git stash -a` | Also stash ignored files |
| `git stash push <file>` | Stash only specific files |
| `git stash -p` | Interactively choose which hunks to stash |
| `git stash list` | Show all stashes |
| `git stash show` | Summary of the latest stash |
| `git stash show -p stash@{1}` | Full diff of a specific stash |
| `git stash pop` | Re-apply the latest stash **and remove it** from the list |
| `git stash apply` | Re-apply the latest stash but **keep it** in the list |
| `git stash apply stash@{2}` | Apply a specific stash |
| `git stash drop stash@{1}` | Delete one stash |
| `git stash clear` | Delete **all** stashes ⚠️ |
| `git stash branch <name>` | Create a new branch from where the stash was made and apply it there |

Example:

```bash
git stash push -m "half-done search bar"
git stash list
```
```
stash@{0}: On feature: half-done search bar
stash@{1}: WIP on main: 4a8c0e2 Add home page
```

`stash@{0}` is always the most recent.

---

## 3. Tips and gotchas

- **New files aren't stashed by default.** Use `git stash -u` if you created files.
- **`pop` can conflict** if the files changed in the meantime. Resolve like a merge
  conflict; the stash is then **kept** (not dropped), so run `git stash drop` once you're done.
- **Stashes are local.** They're never pushed. Don't use them as long-term storage;
  for anything older than a day, commit to a branch instead.
- You can pop a stash on a **different branch** than the one you made it on. Handy
  if you started work on the wrong branch:
  ```bash
  git stash
  git switch -c correct-branch
  git stash pop
  ```

---

## Summary

| Command | Purpose |
|---------|---------|
| `git stash push -m "<msg>"` (`-u` for new files) | Put work aside |
| `git stash list` | See stashes |
| `git stash pop` | Restore and remove |
| `git stash apply` | Restore and keep |
| `git stash drop` / `clear` | Delete one / all |

**Next:** [Lesson 10: Tags and releases](10-tags-and-releases.md).
