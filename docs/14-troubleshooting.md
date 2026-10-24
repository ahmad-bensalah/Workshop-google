# Lesson 14: Troubleshooting: "Help, I Broke It!"

> Find your problem, follow the recipe. When in doubt: **stop, run `git status`,
> read what Git says.** Git's messages usually include the fix.

Before trying anything drastic, make a safety copy:
```bash
git branch backup-before-fix      # a bookmark to where you are now
```
(Delete it later with `git branch -D backup-before-fix`.)

---

## Committing

### 1. "I made a typo in my last commit message"
```bash
git commit --amend -m "Correct message"      # only if not pushed yet
```

### 2. "I forgot to add a file to my last commit"
```bash
git add forgotten-file
git commit --amend --no-edit
```

### 3. "I committed to the wrong branch"
Not pushed yet:
```bash
git branch correct-branch       # bookmark the commit on a new branch
git reset --hard HEAD~1         # remove it from the current branch
git switch correct-branch
```
If the right branch already exists: `git switch right-branch && git cherry-pick <hash>`,
then go back and `git reset --hard HEAD~1` on the wrong one.

### 4. "I want to undo my last commit but keep the work"
```bash
git reset --soft HEAD~1
```

### 5. "I need to undo a commit that's already pushed"
```bash
git revert <hash>
git push
```

### 6. "I committed a password / API key"
1. **Revoke / rotate the secret immediately** (generate a new key). Assume it's compromised.
2. If not pushed: `git reset --soft HEAD~1`, remove the secret, add the file to `.gitignore`, commit again.
3. If pushed: remove it from all history with `git filter-repo` (lesson 13), force-push,
   and ask collaborators to re-clone. GitHub's *Secret scanning* may already have alerted you.

### 7. "Please tell me who you are" error
```
*** Please tell me who you are.
```
You skipped lesson 1:
```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

### 8. "A weird screen opened and I can't exit" (Vim)
Press `Esc`, type `:wq`, press Enter (save & quit). To abort: `Esc`, `:q!`, Enter.
Then set a friendlier editor: `git config --global core.editor "nano"`.

---

## Working directory

### 9. "I want to throw away all my uncommitted changes"
```bash
git restore .          # tracked files back to last commit
git clean -n           # preview deleting untracked files
git clean -fd          # delete untracked files and folders
```
Or in one go: `git reset --hard && git clean -fd` ⚠️

### 10. "I deleted a file by accident"
```bash
git restore <file>                          # if it was committed
git restore --source=HEAD~1 <file>          # if the deletion was also committed
git log --diff-filter=D --oneline -- <file> # find the commit that deleted it
git restore --source=<hash>~1 <file>        # restore from just before that commit
```

### 11. "Git says my changes would be overwritten when I switch/pull"
```
error: Your local changes to the following files would be overwritten by checkout
```
Commit them, or stash: `git stash`, do the switch/pull, then `git stash pop`.

### 12. "`.gitignore` isn't ignoring my file"
It's already tracked: `git rm --cached <file>` then commit. Check the pattern with
`git check-ignore -v <file>`.

### 13. "Every line shows as changed" (line endings or permissions)
- Line endings: set `core.autocrlf` (lesson 12) and add `.gitattributes`.
- File permissions (common on Windows/WSL): `git config core.fileMode false`.
- Check with `git diff --ignore-all-space`.

---

## Branches and merging

### 14. "I'm in 'detached HEAD' state"
Just looking? `git switch main`. Made commits you want? `git switch -c new-branch` first.

### 15. "I'm in the middle of a merge/rebase/cherry-pick and want out"
```bash
git merge --abort
git rebase --abort
git cherry-pick --abort
git revert --abort
```
`git status` tells you which operation is in progress.

### 16. "I resolved the conflict but Git still says unmerged"
You must `git add <file>` after fixing it, then `git commit` (merge) or
`git rebase --continue` (rebase). Check for leftover markers with `git diff --check`.

### 17. "I deleted a branch I needed"
```bash
git reflog                     # find its last commit hash
git branch <name> <hash>
```

### 18. "My reset/rebase destroyed my work"
```bash
git reflog
git reset --hard HEAD@{n}      # n = the entry before the bad operation
```

---

## Remotes and GitHub

### 19. "Push rejected: fetch first / non-fast-forward"
```bash
git pull          # (or git pull --rebase)
git push
```
If you **intentionally** rewrote your own branch: `git push --force-with-lease`.

### 19b. "fatal: Need to specify how to reconcile divergent branches"
Both you and the remote have new commits, and Git wants you to choose how to combine them:
```bash
git config --global pull.rebase false   # merge (simplest); use true for rebase
git pull
```
Or decide just this once: `git pull --no-rebase` or `git pull --rebase`.

### 20. "Permission denied (publickey)"
Your SSH key isn't set up or not added to GitHub:
```bash
ssh -T git@github.com            # test
ls ~/.ssh                        # do you have id_ed25519.pub?
ssh-add ~/.ssh/id_ed25519        # load it into the agent
```
Then add the `.pub` content to GitHub (lesson 7).

### 21. "Authentication failed / support for password authentication was removed"
GitHub doesn't accept account passwords over HTTPS. Use a Personal Access Token
as the password, run `gh auth login`, or switch to SSH:
```bash
git remote set-url origin git@github.com:<user>/<repo>.git
```

### 22. "fatal: refusing to merge unrelated histories"
Happens when you created a README on GitHub *and* a separate repo locally.
```bash
git pull origin main --allow-unrelated-histories
# resolve any conflicts, commit, then push
```

### 23. "fatal: not a git repository"
You're not inside a repo folder. `cd` into it (check with `pwd` and `ls -a` for `.git`),
or `git init` / `git clone` first.

### 24. "fatal: remote origin already exists"
```bash
git remote set-url origin <correct-url>     # or: git remote remove origin, then add again
```

### 25. "src refspec main does not match any"
You haven't made a commit yet, or your branch is called `master`.
```bash
git branch --show-current       # what's my branch called?
git commit -m "Initial commit"  # if there are no commits
git branch -M main              # rename to main
git push -u origin main
```

### 26. "My local main is a mess; I just want it to match GitHub"
```bash
git fetch origin
git switch main
git reset --hard origin/main      # ⚠️ discards local commits & changes on main
```

---

## The universal emergency procedure

1. **Don't panic, don't delete the folder.**
2. `git status`: read every line.
3. `git branch backup-now`: bookmark.
4. `git reflog`: everything you committed is still there.
5. Search the exact error message online; you are not the first. 🙂

**Back to the [README](../README.md).**
