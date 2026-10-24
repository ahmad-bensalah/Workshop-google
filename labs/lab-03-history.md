# Lab 3: Exploring History and Diffs

**Time:** 30 minutes · **Lesson:** [03](../docs/03-history-and-diffs.md)

Use your `recipes` repo from Lab 2, **or** generate a richer one:

```bash
cd ~/git-practice
bash <path-to-workshop>/scripts/make-history-repo.sh
cd history-repo
```

## Tasks

1. Show the history in one line per commit.
2. Show only the last 3 commits, with the list of files each one changed.
3. Show the full details and diff of the **second most recent** commit using `HEAD~1`.
4. Find every commit that touched one specific file.
5. Find commits whose message contains the word "fix" (case-insensitive: add `-i`).
6. Find the commit that first added the word "sugar" to any file (`-S`).
7. Edit a file without staging it. Show the diff. Stage it. Why is `git diff` now
   empty? Which command shows the staged diff? Commit it.
8. Compare the very first commit with the latest one, showing only file names.
9. Print a file as it was in the first commit (`git show <hash>:<file>`).
10. Run `git blame` on a file. Pick a line and show the commit that wrote it.

## Checkpoints

- [ ] You can explain the difference between `git diff`, `git diff --staged` and `git diff HEAD`
- [ ] You can name a commit three ways (hash, `HEAD~n`, branch name)

Solutions: [solutions.md#lab-3](solutions.md#lab-3)
