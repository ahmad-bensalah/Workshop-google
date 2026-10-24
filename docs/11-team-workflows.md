# Lesson 11: Team Workflows, Forks and Pull Requests

> **Goal:** collaborate the way real teams and open-source projects do.
> Concepts: pull requests, code review, forks, `upstream`, GitHub Flow, Git Flow,
> trunk-based development, Conventional Commits.

---

## 1. Pull Requests (PRs)

A **pull request** (GitLab calls it a *merge request*) is a GitHub page that says:
*"I have commits on branch X. Please review them and merge them into `main`."*
It shows the diff, lets people comment on lines, runs automated tests (CI), and
has a big **Merge** button.

### The full PR cycle

```bash
# 1. Start from an up-to-date main
git switch main
git pull

# 2. Create a branch for ONE task
git switch -c feature/dark-mode

# 3. Work in small commits
git add .
git commit -m "Add dark mode toggle"

# 4. Push the branch
git push -u origin feature/dark-mode
```

5. GitHub shows a yellow banner **"Compare & pull request"**. Click it (or go to
   *Pull requests → New*). Choose base `main` ← compare `feature/dark-mode`.
6. Write a clear title and description: **what** changed, **why**, **how to test**,
   screenshots for UI changes. Link issues with `Closes #12` (merging closes the issue automatically).
7. Request reviewers.
8. Reviewers comment. Address feedback by committing more to the **same branch**
   and pushing; the PR updates automatically:
   ```bash
   git add .
   git commit -m "Use CSS variables for colours"
   git push
   ```
9. When approved and checks are green, click **Merge**. GitHub offers three ways:

| Button | Result |
|--------|--------|
| **Create a merge commit** | All branch commits + a merge commit (`--no-ff`) |
| **Squash and merge** | All branch commits combined into one commit on main |
| **Rebase and merge** | Branch commits replayed onto main, no merge commit |

10. Clean up:
```bash
git switch main
git pull                              # get the merged result
git branch -d feature/dark-mode       # delete local branch
git fetch --prune                     # forget the deleted remote branch
```
(GitHub has a **Delete branch** button after merging, or enable auto-delete in repo settings.)

With the GitHub CLI you can do it all from the terminal:
```bash
gh pr create --fill          # create a PR from the current branch
gh pr list                   # list open PRs
gh pr checkout 42            # check out PR #42 locally to test it
gh pr merge 42 --squash      # merge it
```

### Good review etiquette
- Keep PRs **small** (under ~400 changed lines). Big PRs get poor reviews.
- One PR = one purpose.
- Reviewers: be kind and specific; ask questions rather than give orders.
- Authors: don't take comments personally; reply to every comment.

---

## 2. Forks: contributing to projects you don't own

You can't push to someone else's repository. Instead you **fork** it: GitHub makes
a copy under your account that you *can* push to, and you open a PR from your fork
back to the original.

```
  original (upstream)  ◀──── pull request ────  your fork (origin)
  github.com/them/proj                          github.com/you/proj
         │                                             ▲
         └──── git fetch upstream                      │ git push
                     ▼                                 │
                        your computer (local clone) ───┘
```

```bash
# 1. Click "Fork" on GitHub, then clone YOUR fork
git clone git@github.com:you/proj.git
cd proj

# 2. Add the original repo as a second remote called "upstream"
git remote add upstream https://github.com/them/proj.git
git remote -v
#   origin    git@github.com:you/proj.git        (your fork: you push here)
#   upstream  https://github.com/them/proj.git   (original: you pull from here)

# 3. Work on a branch
git switch -c fix-typo
# ... edit, add, commit ...
git push -u origin fix-typo

# 4. Open a PR on GitHub from you:fix-typo → them:main
```

### Keeping your fork up to date

```bash
git switch main
git fetch upstream
git merge upstream/main         # or: git rebase upstream/main
git push origin main            # update your fork on GitHub
```

(GitHub also has a **Sync fork** button.)

### First-contribution checklist
- Read `CONTRIBUTING.md` and the code of conduct.
- Look for issues labelled `good first issue`.
- Comment on the issue before starting work so nobody duplicates it.

---

## 3. Branching strategies

### GitHub Flow (simple; recommended for most teams)
1. `main` is always deployable.
2. Every change gets a short-lived branch from `main`.
3. Open a PR, review, CI passes.
4. Merge to `main` and deploy.

### Git Flow (for scheduled releases)
- `main`: released code only, tagged with versions.
- `develop`: integration branch for the next release.
- `feature/*` from `develop`, `release/*` to prepare a version, `hotfix/*` from `main`.
More ceremony; useful for software shipped in versions (desktop apps, libraries).

### Trunk-based development
Everyone merges very small changes into `main` ("trunk") at least daily, often
behind **feature flags** (switches that hide unfinished features). Requires strong
automated testing.

---

## 4. Commit message conventions

### Conventional Commits
A popular format that tools can read to generate changelogs and version numbers:

```
<type>(<optional scope>): <description>

feat(auth): add password reset via email
fix(cart): round totals to two decimals
docs: explain SSH setup in README
refactor(api): extract validation helper
test: add tests for search filters
chore: upgrade dependencies
style: format with prettier
perf: cache product images
ci: run tests on pull requests
```

Add `!` or a `BREAKING CHANGE:` footer for breaking changes: `feat(api)!: remove v1 endpoints`.

### Referencing issues
`Fixes #42`, `Closes #42`, or `Resolves #42` in a commit message or PR description
closes issue 42 when merged into the default branch.

---

## 5. Protecting `main`

In GitHub *Settings → Branches → Add rule* (branch protection / rulesets) you can require:
- pull requests before merging (no direct pushes),
- at least one approving review,
- passing status checks (CI),
- linear history, signed commits, etc.

This makes it impossible to accidentally break `main`.

---

## 6. Other GitHub features worth knowing

| Feature | What it's for |
|---------|---------------|
| **Issues** | Bug reports, tasks, ideas. Reference with `#number`. |
| **Projects** | Kanban boards for issues and PRs |
| **Actions** | CI/CD: run tests/deploys automatically on push or PR (`.github/workflows/*.yml`) |
| **README.md** | Shown on the repo's front page |
| **LICENSE** | Tells others what they may do with your code |
| **.github/CODEOWNERS** | Auto-request reviews from owners of certain files |
| **Discussions** | Forum-style Q&A |
| **GitHub Pages** | Free hosting for static websites from a repo |
| **Draft PRs** | Open a PR early for feedback, marked "not ready" |

---

## Summary

| Step | Commands |
|------|----------|
| Start a task | `git switch main && git pull && git switch -c <branch>` |
| Share it | `git push -u origin <branch>`, then open a PR |
| Update a PR | commit + `git push` to the same branch |
| After merge | `git switch main && git pull && git branch -d <branch>` |
| Fork setup | `git remote add upstream <original-url>` |
| Sync fork | `git fetch upstream && git merge upstream/main && git push` |

**Next:** [Lab 10](../labs/lab-10-pull-request.md), then
[Lesson 12: .gitignore and configuration](12-gitignore-and-config.md).
