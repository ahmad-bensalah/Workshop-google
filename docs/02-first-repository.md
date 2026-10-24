# Lesson 2: Your First Repository

> **Goal:** create a repository, check its status, stage changes, and make commits.
> Commands: `git init`, `git status`, `git add`, `git commit`, `git rm --cached`.

---

## 1. Create a project folder

```bash
mkdir my-website      # make a new folder
cd my-website         # go inside it
```

## 2. `git init`: start tracking a folder

```bash
git init
```

Output:
```
Initialized empty Git repository in /home/ada/my-website/.git/
```

**What happened?** Git created a hidden `.git` folder inside `my-website`. That
folder *is* the repository: it will store every commit, branch and setting. Your
own files stay where they are. See it with:

```bash
ls -a
```
```
.  ..  .git
```

> **Never edit files inside `.git` by hand**, and never run `git init` inside a
> folder that is already inside another repository (for example, do not run it in
> your home folder). Run `git status` first: if it says "not a git repository",
> you're safe to `git init`.

Useful options:

| Command | Meaning |
|---------|---------|
| `git init` | Turn the current folder into a repository |
| `git init <folder>` | Create `<folder>` and make it a repository |
| `git init -b main` | Start with a branch named `main` (if you did not set `init.defaultBranch`) |

---

## 3. `git status`: what is going on?

Create a file, then ask Git what it sees:

```bash
echo "# My Website" > README.md
git status
```

Output:
```
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	README.md

nothing added to commit but untracked files present (use "git add" to track)
```

Read it line by line:

- `On branch main`: you are on the branch called `main`.
- `No commits yet`: brand-new repository.
- `Untracked files: README.md`: Git sees the file but is not tracking it yet.
- Git even tells you the next command to run: `git add <file>`.

> **Golden habit:** run `git status` before and after every Git command while
> learning. It's free, it never changes anything, and it tells you what to do next.

**Short format:** `git status -s` (or `--short`) shows one line per file:

```
 M README.md      ← modified, not staged (M in the right column)
M  style.css      ← modified and staged (M in the left column)
A  new.txt        ← new file, staged (Added)
?? index.html     ← untracked
```

The left column is the staging area, the right column is the working directory.

---

## 4. `git add`: stage changes

```bash
git add README.md
git status
```

```
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   README.md
```

The file moved from "Untracked" to "Changes to be committed", meaning it is in
the **staging area**, ready for the next snapshot.

Ways to use `git add`:

| Command | What gets staged |
|---------|------------------|
| `git add <file>` | One file |
| `git add <file1> <file2>` | Several files |
| `git add <folder>/` | Everything inside a folder |
| `git add .` | Everything changed in the current folder and below (new, modified, deleted) |
| `git add -A` | Everything changed in the whole repository |
| `git add *.css` | All files matching a pattern |
| `git add -p` | **Interactively** choose pieces ("hunks") of changes, one at a time |

`git add -p` is a superpower. Git shows each changed chunk and asks
`Stage this hunk [y,n,q,a,d,s,e,?]?`. Answer `y` (yes), `n` (no), `s` (split
into smaller pieces), `q` (quit). It lets you commit only part of a file.

> **Careful with `git add .`**: it stages *everything*, including files you may
> not want (passwords, huge files, build output). Check `git status` first, and set
> up a `.gitignore` (lesson 12).

---

## 5. `git commit`: save a snapshot

```bash
git commit -m "Add README"
```

Output:
```
[main (root-commit) 19e3eb1] Add README
 1 file changed, 1 insertion(+)
 create mode 100644 README.md
```

- `main`: the branch the commit was made on.
- `root-commit`: the very first commit (it has no parent).
- `19e3eb1`: the short hash (ID) of the commit. Yours will be different.
- `1 file changed, 1 insertion(+)`: a summary of what changed.

### Commit options

| Command | Meaning |
|---------|---------|
| `git commit -m "<message>"` | Commit with a one-line message |
| `git commit` | Opens your editor to write a longer message (first line = title, blank line, then details) |
| `git commit -m "<title>" -m "<details>"` | Title plus a body paragraph |
| `git commit -a -m "<message>"` | Automatically stage all **modified tracked** files, then commit (does **not** include new untracked files) |
| `git commit -am "<message>"` | Short form of the above |
| `git commit --amend` | Change the last commit (lesson 4) |
| `git commit -v` | Show the diff in the editor while you write the message |

### Writing good commit messages

A good message tells your future self *what* changed and *why*.

```
Fix crash when cart is empty            ← title: imperative mood, ≤ 50 characters

The checkout page divided by the number ← body (optional): explain why,
of items, which was zero for an empty     wrap at ~72 characters
cart. Show a friendly message instead.
```

Rules of thumb:
- Write the title as a command: "Add", "Fix", "Remove", "Update", not "Added" or "Fixes".
  A good test: *"If applied, this commit will ___"*.
- One logical change per commit. "Fix typo and add login and update colours" should be three commits.
- Bad: `stuff`, `fix`, `asdf`, `WIP`, `changes`. Good: `Add password reset email`.

---

## 6. The edit → add → commit loop

This is 90% of everyday Git:

```bash
echo "<h1>Hello</h1>" > index.html      # 1. edit (create a new file)
echo "Welcome to my site" >> README.md  #    and change an existing one
git status                              # 2. look
```
```
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   README.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	index.html
```

Make **two separate commits** because these are two separate ideas:

```bash
git add index.html                       # 3. stage only the new page
git commit -m "Add home page"            # 4. commit it
git add README.md
git commit -m "Add welcome line to README"
git status
```
```
On branch main
nothing to commit, working tree clean
```

"Working tree clean" means everything is committed. 🎉

---

## 7. Unstaging and untracking

Staged something by mistake?

```bash
git restore --staged <file>    # move it back out of the staging area (keeps your edits)
```

(Older tutorials show `git reset HEAD <file>`, which does the same thing.)

Committed a file that should **not** be tracked (for example `.env` with passwords)?

```bash
git rm --cached <file>         # stop tracking it, but keep it on your disk
echo "<file>" >> .gitignore    # make sure it is not added again
git commit -m "Stop tracking <file>"
```

> ⚠️ The file still exists in older commits. If it contained a real secret,
> **change the secret** (rotate the password/key). See lesson 14.

---

## 8. What a commit really is (peek under the hood)

```bash
git cat-file -p HEAD
```
```
tree 6b1c7a...
author Ada Lovelace <ada@example.com> 1729750000 +0000
committer Ada Lovelace <ada@example.com> 1729750000 +0000

Add welcome line to README
```

A commit is a small text record: a pointer to a **tree** (a snapshot of the
folder), a pointer to its **parent** commit (not shown on the first commit), the
author, and the message. That's all. Its hash is computed from this content,
so if *anything* changes, the hash changes. That is why history cannot be
silently altered.

---

## Summary

| Command | Purpose |
|---------|---------|
| `git init` | Create a repository in the current folder |
| `git status` / `git status -s` | Show the state of files |
| `git add <file>` / `git add .` / `git add -p` | Stage changes |
| `git commit -m "<msg>"` | Save staged changes as a commit |
| `git commit -am "<msg>"` | Stage tracked changes and commit in one go |
| `git restore --staged <file>` | Unstage a file |
| `git rm --cached <file>` | Stop tracking a file but keep it on disk |

**Next:** [Lab 2](../labs/lab-02-first-commits.md), then
[Lesson 3: Looking at history](03-history-and-diffs.md).
