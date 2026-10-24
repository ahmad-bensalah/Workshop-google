# Lab 10: Your First Pull Request

**Time:** 45 minutes · **Lesson:** [11](../docs/11-team-workflows.md)

Do this with a friend if you can; otherwise play both roles.

## Part A: PR in your own repo

1. In `recipes`, update `main` from GitHub.
2. Create `feature/pasta`, add `pasta.md`, commit with a Conventional Commit message
   (`feat: add pasta recipe`), push with upstream.
3. On GitHub, open a pull request into `main`. Write a description with
   *What*, *Why*, *How to test*.
4. Review your own PR: leave a comment on a specific line.
5. "Address the feedback": make another commit on the same branch and push.
   Watch the PR update.
6. Merge it with **Squash and merge**.
7. Locally: switch to `main`, pull, delete the local branch, prune remote branches.

## Part B: Contribute via a fork

8. Fork this workshop repo (or a friend's repo, or <https://github.com/firstcontributions/first-contributions>).
9. Clone **your fork**, add the original as `upstream`, verify with `git remote -v`.
10. Create a branch, make a small improvement (fix a typo, add your name to a list), push to your fork.
11. Open a PR from your fork to the original.
12. Simulate the original moving on: sync your fork's `main` from `upstream`.

## Checkpoints

- [ ] Your `recipes` repo on GitHub has a closed, merged PR
- [ ] `git log --oneline` on `main` shows the squashed `feat: add pasta recipe` commit
- [ ] `git remote -v` in your fork clone shows both `origin` and `upstream`

Solutions: [solutions.md#lab-10](solutions.md#lab-10)
