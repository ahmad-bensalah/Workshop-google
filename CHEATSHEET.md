# Git Cheat Sheet

Every command from the workshop on one page. `<x>` = replace with your value.
⚠️ = can lose work, read the lesson first.

## Setup ([lesson 1](docs/01-install-and-configure.md))
| Command | Does |
|---|---|
| `git --version` | Show installed version |
| `git config --global user.name "<name>"` | Set your name |
| `git config --global user.email "<email>"` | Set your email |
| `git config --global init.defaultBranch main` | Default branch name |
| `git config --global core.editor "code --wait"` | Default editor |
| `git config --list --show-origin` | Show all settings and where they come from |
| `git config --global alias.<short> "<command>"` | Create an alias |
| `git help <command>` / `git <command> -h` | Help |

## Start a repository ([lesson 2](docs/02-first-repository.md), [7](docs/07-remotes-and-github.md))
| Command | Does |
|---|---|
| `git init` | Turn current folder into a repo |
| `git clone <url> [folder]` | Copy a remote repo |
| `git clone --depth 1 <url>` | Shallow clone (latest commit only) |

## Everyday work ([lesson 2](docs/02-first-repository.md))
| Command | Does |
|---|---|
| `git status` / `git status -s` | What changed? |
| `git add <file>` | Stage a file |
| `git add .` / `git add -A` | Stage everything |
| `git add -p` | Stage pieces interactively |
| `git commit -m "<msg>"` | Commit staged changes |
| `git commit -am "<msg>"` | Stage tracked files + commit |
| `git rm <file>` | Delete and stage deletion |
| `git rm --cached <file>` | Untrack, keep on disk |
| `git mv <old> <new>` | Rename / move |

## History and differences ([lesson 3](docs/03-history-and-diffs.md))
| Command | Does |
|---|---|
| `git log --oneline --graph --all` | Visual history |
| `git log -p` / `--stat` / `-n 5` | With diffs / file stats / last 5 |
| `git log --author="<name>"` / `--since="2 weeks ago"` | Filter |
| `git log --grep="<text>"` | Search messages |
| `git log -S "<code>"` | Search added/removed code |
| `git log --follow -- <file>` | History of one file |
| `git log main..feature` | Commits in feature not in main |
| `git show <commit>` | One commit's details |
| `git show <commit>:<file>` | File at a commit |
| `git diff` | Unstaged changes |
| `git diff --staged` | Staged changes |
| `git diff HEAD` | All uncommitted changes |
| `git diff <a> <b>` / `git diff main...feature` | Compare commits / branch changes |
| `git blame <file>` | Who changed each line |
| `git shortlog -sn` | Commits per author |

## Undo ([lesson 4](docs/04-undoing-changes.md))
| Command | Does |
|---|---|
| `git restore <file>` | Discard unstaged edits ⚠️ |
| `git restore --staged <file>` | Unstage |
| `git restore --source=<commit> <file>` | Old version of a file |
| `git commit --amend` / `--no-edit` | Fix last commit |
| `git reset --soft HEAD~1` | Uncommit, keep staged |
| `git reset HEAD~1` | Uncommit, keep unstaged |
| `git reset --hard HEAD~1` | Uncommit and discard ⚠️ |
| `git reset --hard origin/main` | Match remote exactly ⚠️ |
| `git revert <commit>` | New commit that undoes `<commit>` (safe when shared) |
| `git clean -n` / `-fd` | Preview / delete untracked files ⚠️ |

## Branches ([lesson 5](docs/05-branching.md))
| Command | Does |
|---|---|
| `git branch` / `-a` / `-vv` | List local / all / with tracking |
| `git switch <branch>` | Switch |
| `git switch -c <new>` | Create + switch |
| `git switch -` | Previous branch |
| `git switch --detach <commit>` | Inspect old commit |
| `git branch -m <new>` | Rename current branch |
| `git branch -d <branch>` / `-D` | Delete merged / force delete ⚠️ |
| `git branch --merged` | Branches already merged |
| `git checkout <branch>` / `-b <new>` | Old-style switch / create |

## Merge ([lesson 6](docs/06-merging-and-conflicts.md))
| Command | Does |
|---|---|
| `git merge <branch>` | Merge into current branch |
| `git merge --no-ff` / `--ff-only` / `--squash` | Merge variants |
| `git merge --abort` | Cancel merge |
| `git checkout --ours/--theirs <file>` | Take one side |
| `git add <file>` then `git commit` | Mark resolved, finish |
| `git mergetool` | Visual conflict tool |
| `git diff --check` | Find leftover markers |

## Remotes ([lesson 7](docs/07-remotes-and-github.md))
| Command | Does |
|---|---|
| `git remote -v` | List remotes |
| `git remote add <name> <url>` | Add remote |
| `git remote set-url origin <url>` | Change URL |
| `git push -u origin <branch>` | First push + set upstream |
| `git push` | Upload commits |
| `git push origin --delete <branch>` | Delete remote branch |
| `git push --force-with-lease` | Safe force push (own branches only) ⚠️ |
| `git fetch` / `--prune` | Download only (safe) |
| `git pull` / `--rebase` / `--ff-only` | Download + integrate |
| `git branch -u origin/<branch>` | Set upstream |
| `ssh-keygen -t ed25519 -C "<email>"` | Create SSH key |
| `ssh -T git@github.com` | Test GitHub SSH |

## Rebase ([lesson 8](docs/08-rebase.md))
| Command | Does |
|---|---|
| `git rebase <base>` | Replay branch onto `<base>` |
| `git rebase -i HEAD~<n>` | Edit last n commits (pick/reword/edit/squash/fixup/drop) |
| `git rebase --continue` / `--skip` / `--abort` | Control rebase |
| `git commit --fixup=<commit>` + `git rebase -i --autosquash <base>` | Auto fixups |
| `git rebase --onto <new> <old> <branch>` | Transplant branch |

## Stash ([lesson 9](docs/09-stash.md))
| Command | Does |
|---|---|
| `git stash push -m "<msg>"` / `-u` | Save work (with untracked) |
| `git stash list` | List |
| `git stash show -p` | Show contents |
| `git stash pop` / `apply` | Restore (remove / keep) |
| `git stash drop` / `clear` | Delete one / all ⚠️ |
| `git stash branch <name>` | New branch from stash |

## Tags ([lesson 10](docs/10-tags-and-releases.md))
| Command | Does |
|---|---|
| `git tag` | List |
| `git tag -a v1.0.0 -m "<msg>"` | Annotated tag |
| `git push origin v1.0.0` / `--tags` | Publish tags |
| `git tag -d v1.0.0` + `git push origin --delete v1.0.0` | Delete tag |
| `git describe --tags` | Position relative to last tag |

## Ignore ([lesson 12](docs/12-gitignore-and-config.md))
| Command | Does |
|---|---|
| `.gitignore` | Patterns to ignore |
| `git check-ignore -v <file>` | Why is it ignored? |
| `git status --ignored` | Show ignored files |
| `git lfs track "*.psd"` | Large files via LFS |

## Power tools ([lesson 13](docs/13-power-tools.md))
| Command | Does |
|---|---|
| `git reflog` | Where HEAD has been (recover anything committed) |
| `git cherry-pick <commit>` / `-x` | Copy a commit here |
| `git bisect start` / `good` / `bad` / `run <cmd>` / `reset` | Find bug-introducing commit |
| `git worktree add <path> <branch>` | Second working folder |
| `git submodule add <url> <path>` / `update --init --recursive` | Nested repos |
| `git grep "<text>"` | Search tracked files |
| `git archive --format=zip -o out.zip HEAD` | Export snapshot |
| `git gc` / `git fsck` | Maintenance / integrity check |

## Commit references
`HEAD` current · `HEAD~1` parent · `HEAD~3` 3 back · `HEAD^2` 2nd parent of merge ·
`origin/main` remote-tracking · `HEAD@{2}` reflog entry · `ORIG_HEAD` before last reset/merge/rebase

## Emergency
```bash
git status                  # read it!
git branch backup-now       # bookmark before experimenting
git reflog                  # find lost commits
git reset --hard HEAD@{n}   # go back to a reflog entry
git merge --abort | git rebase --abort | git cherry-pick --abort
```
