# Lab 8: Rebase and Cleaning History

**Time:** 40 minutes · **Lesson:** [08](../docs/08-rebase.md)

```bash
cd ~/git-practice
bash <path-to-workshop>/scripts/make-rebase-repo.sh
cd rebase-repo
git log --oneline --graph --all
```

The script makes `main` with 2 new commits, and `feature/search` (branched earlier)
with 5 messy commits: `Add search box`, `WIP`, `fix typo`, `oops`, `Add search results page`.

## Tasks

1. Look at the graph. Note the hashes of the `feature/search` commits.
2. Switch to `feature/search` and rebase it onto `main`. Look at the graph again.
   Did the hashes change? Why?
3. Use interactive rebase on the last 5 commits of `feature/search` to end up with
   exactly **two** commits:
   - `Add search box` (containing the WIP, typo and oops changes)
   - `Add search results page`
4. Switch to `main` and merge `feature/search`. Was it a fast-forward?
5. Bonus (fixup workflow): create a branch, make a commit `Add footer`, then a
   change that belongs in it. Commit with `--fixup=<hash>`, then
   `git rebase -i --autosquash main`.
6. Bonus (conflict): run `make-rebase-repo.sh` again in a new folder with
   `bash make-rebase-repo.sh conflict`, rebase, resolve the conflict and continue.
   Then try again and use `--abort` instead.

## Checkpoints

- [ ] `git log --oneline main` is a straight line (no merge commits)
- [ ] There are no `WIP`, `fix typo` or `oops` commits in it

Solutions: [solutions.md#lab-8](solutions.md#lab-8)
