# Lab 1: Install and Configure

**Time:** 15 minutes · **Lesson:** [01](../docs/01-install-and-configure.md)

## Tasks

1. Open a terminal and print the Git version.
2. Set your name and email globally.
3. Set the default branch name to `main`.
4. Set your editor to one you know (VS Code, nano, Notepad...).
5. Tell `git pull` to merge when histories diverge (`pull.rebase false`).
6. Create an alias `lg` for `log --oneline --graph --all`.
7. List all your global settings.
8. Create a practice folder `~/git-practice` and move into it.
9. Open the help page for `git commit`, find what `-a` does, then exit the pager.

## Checkpoints

- [ ] `git --version` prints 2.23 or higher
- [ ] `git config user.name` prints your name
- [ ] `git config user.email` prints your email
- [ ] `git config init.defaultBranch` prints `main`
- [ ] `git config pull.rebase` prints `false`
- [ ] `git config --global --list` shows an `alias.lg=...` line
- [ ] `pwd` ends in `git-practice`

Solutions: [solutions.md#lab-1](solutions.md#lab-1)
