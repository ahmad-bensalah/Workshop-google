# Lab 6: Merging and Conflicts

**Time:** 40 minutes · **Lesson:** [06](../docs/06-merging-and-conflicts.md)

## Part A: Fast-forward and merge commits (in `recipes`)

1. Merge `feature/sweets` into `main`. Was it a fast-forward or a merge commit? Why?
2. Create `feature/drinks` from `main`, commit `lemonade.md`, go back to `main` and
   merge it with `--no-ff`. Look at the graph.
3. Delete both merged branches with the safe delete.

## Part B: Conflicts (generated repo)

```bash
cd ~/git-practice
bash <path-to-workshop>/scripts/make-conflict-repo.sh
cd conflict-repo
git log --oneline --graph --all
```

The script creates `main` and `feature/new-title`, both changing the same line of
`index.html`, plus `feature/menu`, which changes different lines of `menu.txt` and
a line also changed on main.

4. Merge `feature/new-title` into `main`. Read the conflict message and `git status`.
5. Open `index.html`, identify "ours" and "theirs", and combine both titles into one.
6. Mark it resolved and finish the merge.
7. Merge `feature/menu`. This time, **abort** the merge.
8. Merge it again and resolve by keeping **their** version of the whole file with
   one command. Finish the merge.
9. Bonus: set `merge.conflictstyle` to `zdiff3`, use `git reflog` to find where
   `main` was before both merges and `git reset --hard` back to it, merge
   `feature/new-title` again, and compare how the markers look.

## Checkpoints

- [ ] `git log --oneline --graph` shows two merge commits on `main`
- [ ] `grep -rn "<<<<<<<" .` finds nothing
- [ ] `git status` is clean

Solutions: [solutions.md#lab-6](solutions.md#lab-6)
