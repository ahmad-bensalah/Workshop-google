# Lab 7: GitHub, Push and Pull

**Time:** 45 minutes · **Lesson:** [07](../docs/07-remotes-and-github.md)
**Needs:** a GitHub account and internet.

## Tasks

1. Create an SSH key (if you don't have one), add it to GitHub, and test with `ssh -T git@github.com`.
2. On GitHub, create an **empty** repository `recipes` (no README).
3. Connect your local `recipes` repo to it as `origin` and push `main` with upstream tracking.
4. Refresh GitHub and browse your commits online.
5. **Simulate a teammate:** clone the repo into a second folder:
   ```bash
   cd ~/git-practice
   git clone git@github.com:<you>/recipes.git recipes-teammate
   ```
6. In `recipes-teammate`, add `tea.md`, commit, push.
7. Back in the original `recipes`: run `git status`. Does it know about the new commit? Why not?
8. Run `git fetch`, then `git status` again. Show the incoming commit with
   `git log main..origin/main`. Then `git pull`.
9. **Cause a rejected push:** commit a change in `recipes-teammate` and push it.
   Commit a *different file* in `recipes` and try to push. Read the error. Fix it with
   `git pull` then `git push`.
10. Create a branch `feature/coffee` in `recipes`, push it to GitHub, see it on
    GitHub, then delete it on the remote and locally.
11. Run `git remote -v`, `git branch -vv` and `git remote show origin`. Explain each output.

## Checkpoints

- [ ] Your repo is visible on GitHub with all commits
- [ ] Both local folders show `Your branch is up to date with 'origin/main'` after a final `git pull`
- [ ] `feature/coffee` no longer exists on GitHub

Solutions: [solutions.md#lab-7](solutions.md#lab-7)
