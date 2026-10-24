# Git Workshop: From Zero to Confident

Welcome! This repository is a complete, self-paced workshop that takes you from
"I have never used Git" to "I can work on a team project with branches, pull
requests, and conflict resolution without panicking."

You need **no prior knowledge** of Git or version control. You only need a
computer, a terminal, and about 6 to 10 hours spread over a few days.

---

## How to use this workshop

1. Read the lessons **in order**. Each one builds on the previous one.
2. **Type every command yourself.** Do not copy and paste. Typing builds memory.
3. At the end of each lesson, do the matching **lab** in [`labs/`](labs/).
4. If you get stuck, check [`docs/14-troubleshooting.md`](docs/14-troubleshooting.md)
   and the [`GLOSSARY.md`](GLOSSARY.md).
5. Keep [`CHEATSHEET.md`](CHEATSHEET.md) open in another window as a quick reference.

> **Tip:** Make a folder called `git-practice` somewhere on your computer and do all
> your experiments there. You can delete it and start again at any time. Nothing
> you do in it can break your computer.

---

## Learning path

| # | Lesson | What you will learn | Lab |
|---|--------|---------------------|-----|
| 0 | [What is Git?](docs/00-what-is-git.md) | Version control, why Git exists, the mental model | – |
| 1 | [Install and configure](docs/01-install-and-configure.md) | Installing Git, `git config`, your identity, your editor | [Lab 1](labs/lab-01-setup.md) |
| 2 | [Your first repository](docs/02-first-repository.md) | `init`, `status`, `add`, `commit`, the three areas | [Lab 2](labs/lab-02-first-commits.md) |
| 3 | [Looking at history](docs/03-history-and-diffs.md) | `log`, `show`, `diff`, `blame` | [Lab 3](labs/lab-03-history.md) |
| 4 | [Undoing things](docs/04-undoing-changes.md) | `restore`, `reset`, `revert`, `commit --amend`, `clean`, `rm`, `mv` | [Lab 4](labs/lab-04-undo.md) |
| 5 | [Branches](docs/05-branching.md) | `branch`, `switch`, `checkout`, HEAD | [Lab 5](labs/lab-05-branches.md) |
| 6 | [Merging and conflicts](docs/06-merging-and-conflicts.md) | `merge`, fast-forward vs. merge commit, fixing conflicts | [Lab 6](labs/lab-06-conflicts.md) |
| 7 | [Remotes and GitHub](docs/07-remotes-and-github.md) | `clone`, `remote`, `push`, `fetch`, `pull`, SSH keys, tokens | [Lab 7](labs/lab-07-github.md) |
| 8 | [Rebase](docs/08-rebase.md) | `rebase`, interactive rebase, squashing, the golden rule | [Lab 8](labs/lab-08-rebase.md) |
| 9 | [Stash](docs/09-stash.md) | Saving unfinished work with `stash` | [Lab 9](labs/lab-09-stash-tags.md) |
| 10 | [Tags and releases](docs/10-tags-and-releases.md) | `tag`, semantic versioning, GitHub releases | [Lab 9](labs/lab-09-stash-tags.md) |
| 11 | [Team workflows](docs/11-team-workflows.md) | Forks, pull requests, code review, GitHub Flow, good commit messages | [Lab 10](labs/lab-10-pull-request.md) |
| 12 | [.gitignore and configuration](docs/12-gitignore-and-config.md) | Ignoring files, aliases, line endings, useful settings | – |
| 13 | [Power tools](docs/13-power-tools.md) | `reflog`, `cherry-pick`, `bisect`, `worktree`, `submodule`, hooks | [Lab 11](labs/lab-11-rescue.md) |
| 14 | [Troubleshooting](docs/14-troubleshooting.md) | "Help, I broke it!" recipes for the most common problems | – |

Reference material:

- [CHEATSHEET.md](CHEATSHEET.md): every command in this workshop on one page
- [GLOSSARY.md](GLOSSARY.md): every Git word explained in plain English
- [labs/solutions.md](labs/solutions.md): answers to every lab
- [scripts/](scripts/): helper scripts that build practice repositories for you

---

## How to read the command examples

Commands are shown in code blocks like this:

```bash
git status
```

- Type only the command, not the `$` sign if you see one.
- Text in `<angle-brackets>` is a placeholder. Replace it, including the brackets.
  For example `git switch <branch-name>` becomes `git switch login-page`.
- Lines starting with `#` are comments. They explain the command; you do not type them.
- Output that Git prints back is shown in a separate block labelled "Output".

---

## What "mastering Git" means at the end of this workshop

When you finish, you should be able to:

- [ ] Explain the working directory, staging area, and repository
- [ ] Create a repository and make clean, well-described commits
- [ ] Read history and compare any two versions of a file
- [ ] Undo almost any mistake safely
- [ ] Create, switch, merge, and delete branches
- [ ] Resolve merge conflicts calmly
- [ ] Push to and pull from GitHub using SSH
- [ ] Contribute to someone else's project with a fork and a pull request
- [ ] Clean up history with interactive rebase before sharing it
- [ ] Rescue "lost" work with `reflog`
- [ ] Find the commit that introduced a bug with `bisect`

Tick the boxes as you go!

---

## Publishing this workshop to your own GitHub

This folder is ready to become a repository. From inside the `git-workshop` folder:

```bash
git init
git add .
git commit -m "Initial commit: git workshop"
git branch -M main
git remote add origin git@github.com:<your-username>/git-workshop.git
git push -u origin main
```

Every one of those commands is explained in lessons 2 and 7. (Create the empty
`git-workshop` repository on GitHub first, without a README, so there is nothing
to conflict with.)

## License

Content is released under the [MIT License](LICENSE). Share it, fork it, teach with it.
