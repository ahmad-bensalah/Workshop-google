# Lab Solutions

Try each lab yourself first! Hashes in your repo will differ from any shown here.
There's often more than one correct answer; these are the most common.

---

## Lab 1

```bash
git --version
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main
git config --global core.editor "code --wait"     # or "nano", "notepad"
git config --global pull.rebase false
git config --global alias.lg "log --oneline --graph --all"
git config --global --list
mkdir ~/git-practice && cd ~/git-practice
git help commit        # search with /-a, quit with q
```
`-a` (`--all`) automatically stages modified and deleted tracked files before committing.

---

## Lab 2

```bash
mkdir recipes && cd recipes
git init
git status                          # "No commits yet", nothing to commit
echo "# My Recipe Book" > README.md
git status                          # README.md is Untracked
git add README.md
git status                          # "Changes to be committed: new file: README.md" (Staged)
git commit -m "Add README"

echo "Flour, milk, eggs" > pancakes.md
echo "Eggs, butter" > omelette.md
git add pancakes.md && git commit -m "Add pancake recipe"
git add omelette.md && git commit -m "Add omelette recipe"

echo "Add sugar" >> pancakes.md
echo "Recipes from my family" >> README.md
git status -s
#  M README.md     ← " M": modified in working dir, NOT staged (right column)
#  M pancakes.md
git add README.md && git commit -m "Describe the recipe book"
git add pancakes.md && git commit -m "Add sugar to pancakes"

echo "temp" > notes.tmp
git add .
git restore --staged notes.tmp      # unstaged, file still exists
rm notes.tmp

# Bonus: edit two separate places in omelette.md, then
git add -p omelette.md              # y for the first hunk, n for the second
git commit -m "Add salt to omelette"
git restore omelette.md             # (or commit the second edit too)
```
If both edits are in one hunk, press `s` to split it, or `e` to edit it manually.

---

## Lab 3

```bash
git log --oneline
git log -3 --stat
git show HEAD~1
git log --oneline -- pancakes.md            # (history-repo: --follow -- dessert-brownies.md shows the rename too)
git log --oneline -i --grep="fix"
git log --oneline -S "sugar"                # oldest result at the bottom is the first one
# edit a file, then:
git diff                                    # shows the change
git add <file>
git diff                                    # empty: diff compares working dir vs. STAGING, which now match
git diff --staged                           # shows the staged change
git commit -m "Describe change"
git diff --name-only $(git rev-list --max-parents=0 HEAD) HEAD
git show <first-hash>:README.md
git blame README.md
git show <hash-from-blame>
```
`git rev-list --max-parents=0 HEAD` prints the hash of the very first (root) commit.

---

## Lab 4

```bash
# 1
git restore README.md
# 2
echo "x" >> pancakes.md && git add pancakes.md
git restore --staged pancakes.md
git restore pancakes.md
# 3
echo "Waffles" > waffles.md && git add waffles.md && git commit -m "wafles"
git commit --amend -m "Add waffles recipe"
# 4
echo "Maple" > syrup.md && git add syrup.md
git commit --amend --no-edit
# 5
echo 1 > one.txt && git add one.txt && git commit -m "one"
echo 2 > two.txt && git add two.txt && git commit -m "two"
git reset --soft HEAD~2
git status                         # both files staged
git commit -m "Add one and two"
# 6
echo bad > bad.txt && git add bad.txt && git commit -m "Bad idea"
git reset --hard HEAD~1
# 7
git revert HEAD --no-edit          # HEAD is "Add one and two"
# 8
git log --oneline -- pancakes.md   # bottom line = first commit for that file
git restore --source=<that-hash> pancakes.md
cat pancakes.md
git restore pancakes.md            # back to the committed version
# 9
touch junk1.tmp junk2.tmp && mkdir junkdir && touch junkdir/x
git clean -nd
git clean -fd
# 10
git mv omelette.md eggs.md
git rm waffles.md
git commit -m "Rename omelette to eggs and remove waffles"
```

---

## Lab 5

```bash
git branch                                 # * main
git switch -c feature/desserts
echo "Chocolate" > brownies.md && git add . && git commit -m "Add brownies"
git switch main
ls                                         # no brownies.md: it only exists in commits on feature/desserts
echo "Lettuce" > salad.md && git add . && git commit -m "Add salad"
git log --oneline --graph --all
git switch -                               # back to feature/desserts
git branch -m feature/desserts feature/sweets
git switch -c experiment
echo "silly" > silly.txt && git add . && git commit -m "Silly"
git switch main
git branch -d experiment                   # error: not fully merged
git branch -D experiment
git switch --detach $(git rev-list --max-parents=0 HEAD)
ls
git switch main
# Bonus
git switch --detach HEAD~1
echo "x" > x.txt && git add . && git commit -m "Detached work"
git switch -c rescued
```

---

## Lab 6

**Part A**
```bash
git switch main
git merge feature/sweets
```
It creates a **merge commit** because `main` got a new commit (`Add salad`) after
the branch was created. If `main` hadn't moved, it would fast-forward.
```bash
git switch -c feature/drinks
echo "Lemons" > lemonade.md && git add . && git commit -m "Add lemonade"
git switch main
git merge --no-ff feature/drinks
git log --oneline --graph
git branch -d feature/sweets feature/drinks
```

**Part B**
```bash
git merge feature/new-title          # CONFLICT in index.html
git status                           # both modified: index.html
# edit index.html, e.g.:
#   <h1>Welcome to The Golden Spoon: fresh food, friendly prices</h1>
# and delete the <<<<<<< ======= >>>>>>> lines
git add index.html
git commit --no-edit                 # or: git merge --continue

git merge feature/menu               # CONFLICT in menu.txt
git merge --abort
git merge feature/menu
git checkout --theirs menu.txt
git add menu.txt
git commit --no-edit
grep -rn "<<<<<<<" .                 # nothing
```
"Ours" (`HEAD`) = the `main` version; "theirs" = the branch being merged.

---

## Lab 7

```bash
ssh-keygen -t ed25519 -C "you@example.com"
eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub            # paste into GitHub → Settings → SSH and GPG keys
ssh -T git@github.com

cd ~/git-practice/recipes
git remote add origin git@github.com:<you>/recipes.git
git branch -M main
git push -u origin main

cd ~/git-practice
git clone git@github.com:<you>/recipes.git recipes-teammate
cd recipes-teammate
echo "Green tea" > tea.md && git add . && git commit -m "Add tea" && git push

cd ../recipes
git status          # "up to date": it doesn't know yet; status never contacts GitHub
git fetch
git status          # "behind 'origin/main' by 1 commit"
git log --oneline main..origin/main
git pull

# rejected push
cd ../recipes-teammate && echo "x" > a.md && git add . && git commit -m "Add a" && git push
cd ../recipes && echo "y" > b.md && git add . && git commit -m "Add b"
git push            # rejected (fetch first)
git pull            # creates a merge commit (or use --rebase)
git push

git switch -c feature/coffee
echo "Espresso" > coffee.md && git add . && git commit -m "Add coffee"
git push -u origin feature/coffee
git switch main
git push origin --delete feature/coffee
git branch -D feature/coffee         # -D because it was never merged

git remote -v
git branch -vv
git remote show origin
```

---

## Lab 8

```bash
git log --oneline --graph --all
git switch feature/search
git rebase main
git log --oneline --graph --all     # new hashes: the commits were re-created on a new parent
git rebase -i HEAD~5
```
In the editor:
```
pick   <h1> Add search box
fixup  <h2> WIP
fixup  <h3> fix typo
fixup  <h4> oops
pick   <h5> Add search results page
```
```bash
git switch main
git merge feature/search            # Fast-forward: main had nothing new since the rebase
git log --oneline
```
Bonus (fixup):
```bash
git switch -c feature/footer
echo "<footer>v1</footer>" > footer.html && git add . && git commit -m "Add footer"
echo "<footer>v2</footer>" > footer.html && git add .
git commit --fixup=HEAD
git rebase -i --autosquash main     # the fixup line is already in place; just save
```
Bonus (conflict): in conflict mode, the `oops` commit conflicts in `style.css`.
Edit the file to keep the rule you want, then `git add style.css && git rebase --continue`.

---

## Lab 9

```bash
git switch -c feature/soups
echo "Soups coming soon" >> README.md
echo "Tomato" > soup.md
git stash push -u -m "soups in progress"
git status                           # clean
git switch main
# fix a typo, then:
git commit -am "Fix typo"
git switch feature/soups
git stash list
git stash show -p stash@{0}
git stash pop

echo "more" >> README.md
git stash
git stash apply
git stash list                       # still there
git stash drop

# Bonus
git switch main && echo z >> README.md && git stash
git stash branch feature/from-stash

# Tags
git switch main
git tag -a v1.0.0 -m "First release"
git tag -a v0.1.0 <older-hash> -m "Early version"
git tag
git show v1.0.0
git push origin --tags
echo "new" > new.md && git add . && git commit -m "Add new"
git describe --tags      # v1.0.0-1-g<hash>: 1 commit after v1.0.0, at commit <hash>
git tag -d v0.1.0
git push origin --delete v0.1.0
```

---

## Lab 10

```bash
git switch main && git pull
git switch -c feature/pasta
echo "Spaghetti" > pasta.md && git add . && git commit -m "feat: add pasta recipe"
git push -u origin feature/pasta
# open PR on GitHub, comment, then:
echo "Add basil" >> pasta.md && git commit -am "feat: add basil"
git push
# Squash and merge on GitHub, then:
git switch main
git pull
git branch -d feature/pasta          # may need -D: squash creates a NEW commit, so Git
                                     # doesn't see the branch's commits as merged
git fetch --prune

# Fork
git clone git@github.com:<you>/<repo>.git
cd <repo>
git remote add upstream https://github.com/<owner>/<repo>.git
git remote -v
git switch -c fix-typo
# edit, commit
git push -u origin fix-typo
# open PR on GitHub from your fork
git switch main
git fetch upstream
git merge upstream/main
git push origin main
```

---

## Lab 11

```bash
# Mission 1
for f in A B C; do echo $f > $f.txt; git add .; git commit -m "$f"; done
git reset --hard HEAD~3
git reflog                       # HEAD@{1} is "commit: C"
git reset --hard HEAD@{1}

# Mission 2
git switch -c feature/doomed
echo 1 > d1 && git add . && git commit -m d1
echo 2 > d2 && git add . && git commit -m d2
git switch main
git branch -D feature/doomed     # prints "Deleted branch feature/doomed (was abc1234)."
git branch feature/doomed abc1234   # or find the hash in git reflog

# Mission 3
git switch -c feature/big
echo 1 > b1 && git add . && git commit -m "Big part 1"
echo fix > fix.txt && git add . && git commit -m "Fix critical bug"
echo 3 > b3 && git add . && git commit -m "Big part 3"
git log --oneline                # note the hash of "Fix critical bug"
git switch main
git cherry-pick -x <hash>

# Mission 4
echo exp > exp.txt && git add . && git commit -m "Add experimental feature"
git branch feature/experimental
git reset --hard HEAD~1

# Mission 5 (manual)
git bisect start
git bisect bad
git bisect good $(git rev-list --max-parents=0 HEAD)
bash test.sh                     # then git bisect good / git bisect bad, repeat
git bisect reset

# Mission 5 (automatic)
git bisect start HEAD $(git rev-list --max-parents=0 HEAD)
git bisect run bash test.sh      # prints "<hash> is the first bad commit"
git bisect reset
git revert --no-edit <bad-hash>
bash test.sh                     # PASS
```
