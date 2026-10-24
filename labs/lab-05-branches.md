# Lab 5: Branches

**Time:** 30 minutes · **Lesson:** [05](../docs/05-branching.md)

## Tasks

1. In `recipes`, list branches. Which one are you on?
2. Create and switch to `feature/desserts`. Add `brownies.md` and commit.
3. Switch back to `main`. Does `brownies.md` exist in the folder? Why?
4. On `main`, add `salad.md` and commit.
5. Draw the history with `git log --oneline --graph --all`. Sketch it on paper too.
6. Switch to the previous branch using the shortcut.
7. Rename `feature/desserts` to `feature/sweets`.
8. Create a branch `experiment`, commit something silly, switch to `main` and
   try to delete `experiment` with `-d`. Read the error. Delete it with `-D`.
9. Check out the first commit of the repo in **detached HEAD** mode. Look at the
   files. Return to `main`.
10. Bonus: in detached HEAD, make a commit, then save it into a new branch
    `rescued` before leaving.

## Checkpoints

- [ ] `git branch` shows `main` and `feature/sweets` (and `rescued` if you did the bonus)
- [ ] The graph shows `main` and `feature/sweets` diverging

Solutions: [solutions.md#lab-5](solutions.md#lab-5)
