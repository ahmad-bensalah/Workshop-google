# Lab 4: Undoing Mistakes

**Time:** 40 minutes · **Lesson:** [04](../docs/04-undoing-changes.md)

Work in your `recipes` repo. Run `git log --oneline` and `git status` often.

## Tasks

1. **Discard an edit.** Delete all text in `README.md`, save, then restore it with Git.
2. **Unstage.** Edit `pancakes.md`, stage it, then unstage it (keeping the edit). Then discard the edit.
3. **Amend a message.** Commit a new file `waffles.md` with the message `wafles`. Fix the message.
4. **Amend content.** Create `syrup.md` and add it to that same last commit without changing the message.
5. **Soft reset.** Make two quick commits (`one.txt`, `two.txt`). Undo both commits
   but keep the files staged. Then commit them as one commit `Add one and two`.
6. **Hard reset.** Make a commit `Bad idea` (any file). Throw it away completely.
7. **Revert.** Pretend `Add one and two` was already pushed. Undo it safely with a
   new commit.
8. **Old version.** Restore `pancakes.md` as it was in its first commit, look at
   it, then put it back to the current version.
9. **Clean.** Create `junk1.tmp`, `junk2.tmp` and a folder `junkdir/` with a file inside.
   Preview, then delete them with `git clean`.
10. **Rename and delete.** Rename `omelette.md` to `eggs.md` with Git, delete
    `waffles.md` with Git, and commit.

## Checkpoints

- [ ] `git log --oneline` contains a `Revert "Add one and two"` commit
- [ ] There's no `Bad idea` commit in `git log`
- [ ] `git status` is clean, and `eggs.md` exists

Solutions: [solutions.md#lab-4](solutions.md#lab-4)
