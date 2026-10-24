# Final Challenge: A Small Team Project

**Time:** 2 hours · Best with 2 or 3 people (or simulate teammates with several clones).

Build a tiny static website, **"Our Team Page"**, using a professional workflow.

## Rules

- `main` is protected: nobody pushes to it directly (enable branch protection on GitHub).
- Every change goes through a branch and a pull request with at least one review.
- Commit messages follow Conventional Commits.
- No secrets or junk files in the repo (add a `.gitignore` first).

## Steps

1. **Setup** (one person): create the repo on GitHub with a README and `.gitignore`,
   add teammates as collaborators, protect `main`.
2. **Everyone**: clone it.
3. **Parallel features**: each person creates a branch and builds one section of
   `index.html`: header, member list, footer. **All of you edit `index.html`** so
   conflicts happen on purpose.
4. Open PRs. Review each other's PRs: at least one comment each.
5. Merge the first PR. The others must update their branch (merge **or** rebase
   `main` into it), resolve conflicts, and push (use `--force-with-lease` if rebased).
6. Someone introduces a bug and it gets merged. Another person reverts it with a PR.
7. Tag the result `v1.0.0` and create a GitHub Release with generated notes.
8. Bonus: enable GitHub Pages so the site is live.
9. Bonus: add a `pre-commit` hook that blocks commits containing `TODO`.

## You've mastered Git when you can...

- [ ] Explain every commit in `git log --oneline --graph --all`
- [ ] Resolve a conflict without help
- [ ] Recover from any mistake using the [troubleshooting guide](../docs/14-troubleshooting.md) and reflog
- [ ] Review someone else's PR and give useful feedback

Congratulations! 🎓
