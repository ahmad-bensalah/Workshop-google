# Glossary

Plain-English definitions of every Git word used in this workshop, A to Z.

| Term | Meaning |
|------|---------|
| **Ahead / behind** | How many commits your branch has that its upstream doesn't (ahead) and vice versa (behind). Shown by `git status`. |
| **Alias** | Your own shortcut name for a Git command, e.g. `git st` for `git status`. |
| **Annotated tag** | A tag that stores a message, author and date. Recommended for releases. |
| **Bisect** | Binary search through history to find the commit that introduced a bug. |
| **Blame** | Shows which commit and author last changed each line of a file. |
| **Branch** | A movable named pointer to a commit. Moves forward when you commit on it. |
| **Checkout** | Older command that switches branches or restores files. Replaced by `switch` and `restore`. |
| **Cherry-pick** | Copy one existing commit onto your current branch as a new commit. |
| **Clean (working tree)** | No uncommitted changes. `git status` says "nothing to commit, working tree clean". |
| **Clone** | A full copy of a remote repository, including all history. |
| **Commit** | A saved snapshot of the project, with author, date, message and parent. Also the verb for creating one. |
| **Commit hash / SHA** | The unique ID of a commit, e.g. `a1b2c3d…`. Computed from the commit's content. |
| **Conflict** | When Git can't automatically combine two changes to the same lines. You resolve it manually. |
| **Conflict markers** | `<<<<<<<`, `=======`, `>>>>>>>` lines Git inserts into a conflicted file. |
| **Detached HEAD** | HEAD points straight at a commit instead of a branch. Fine for looking; create a branch before committing. |
| **Diff** | The line-by-line differences between two versions. |
| **Fast-forward** | A merge where the branch pointer simply moves forward because there's no divergent work. No merge commit. |
| **Fetch** | Download new commits from a remote without changing your branches or files. |
| **Fork** | Your own server-side copy of someone else's repository on GitHub, used to propose changes. |
| **Force push** | Overwrite a remote branch with your version. Dangerous on shared branches; prefer `--force-with-lease`. |
| **.gitignore** | File listing patterns of files Git should not track. |
| **GitHub** | A website that hosts Git repositories and adds pull requests, issues, Actions, etc. |
| **HEAD** | Pointer to where you are right now: usually the current branch. |
| **Hook** | A script Git runs automatically at certain events (before commit, before push...). |
| **Hunk** | One block of changed lines in a diff. |
| **Index** | Another name for the staging area. |
| **Interactive rebase** | `git rebase -i`: edit, reorder, squash or drop commits. |
| **LFS (Large File Storage)** | Extension that stores big files outside normal Git history. |
| **Main / master** | The conventional name of the primary branch. `main` is the modern default. |
| **Merge** | Combine the history of two branches. |
| **Merge commit** | A commit with two parents, created when merging divergent branches. |
| **Origin** | Default name for the remote you cloned from. |
| **Parent** | The commit that came directly before. Merge commits have two. |
| **Pull** | `fetch` + `merge` (or `rebase`): download and integrate remote changes. |
| **Pull request (PR)** | A request on GitHub to merge one branch into another, with review and discussion. GitLab: "merge request". |
| **Push** | Upload your commits to a remote. |
| **Rebase** | Replay commits on top of another base, producing new commits and linear history. |
| **Reflog** | Local log of everywhere HEAD and branches have pointed. Your recovery tool. |
| **Remote** | A named link to another copy of the repository (e.g. on GitHub). |
| **Remote-tracking branch** | Read-only local copy of a remote branch's position, like `origin/main`. Updated by fetch. |
| **Repository (repo)** | A project folder plus its full history (stored in `.git`). |
| **Reset** | Move the current branch to another commit, optionally changing staging area and files. |
| **Restore** | Bring files back to a version from the staging area or a commit. |
| **Revert** | Create a new commit that undoes an earlier commit. Safe for shared history. |
| **Squash** | Combine several commits into one. |
| **Staging area** | Where you assemble the changes for the next commit (`git add`). |
| **Stash** | Temporary storage for uncommitted changes. |
| **Submodule** | A Git repository embedded inside another at a fixed commit. |
| **Switch** | Change to another branch (`git switch`). |
| **Tag** | A fixed name for a specific commit, usually a version like `v1.0.0`. |
| **Tracked file** | A file Git is managing (it was added and committed at some point). |
| **Untracked file** | A file in the folder that Git isn't managing yet. |
| **Upstream** | (1) The remote branch your local branch tracks. (2) In forks, the original repository. |
| **Working directory / working tree** | The actual files on your disk that you edit. |
| **Worktree** | An extra working directory attached to the same repository. |
