# Practice scripts

Each script builds a ready-made practice repository **in your current folder**,
so you can jump straight into the interesting part of a lab.

| Script | Creates | Used in |
|--------|---------|---------|
| `make-history-repo.sh` | `history-repo/`: 12 commits of recipes to explore | Lab 3 |
| `make-conflict-repo.sh` | `conflict-repo/`: branches guaranteed to conflict | Lab 6 |
| `make-rebase-repo.sh [conflict]` | `rebase-repo/`: a messy feature branch behind main | Lab 8 |
| `make-bisect-repo.sh` | `bisect-repo/`: 30 commits, one hides a bug | Lab 11 |

Usage (Git Bash on Windows, Terminal on macOS/Linux):

```bash
cd ~/git-practice
bash ~/path/to/git-workshop/scripts/make-conflict-repo.sh
cd conflict-repo
```

To start over, delete the folder (`rm -rf conflict-repo`) and run the script again.
The scripts need Git 2.28 or newer. `_common.sh` holds shared helpers and isn't run directly.
