# Lesson 0: What is Git?

> **Goal:** understand *what* Git does and *why* before typing any command.
> No commands in this lesson, just ideas. Take 15 minutes; it will save you hours later.

---

## 1. The problem Git solves

Have you ever had files like these?

```
report.docx
report_v2.docx
report_v2_final.docx
report_v2_final_REALLY_final.docx
report_v2_final_REALLY_final_fixed_by_sam.docx
```

This is "version control by hand". It has problems:

- You cannot easily tell **what changed** between two versions.
- You cannot tell **who** changed it or **why**.
- Two people editing at once means someone's work gets overwritten.
- Going back to "the version from last Tuesday" is guesswork.

**Version control** software solves this. It records every change to a set of
files over time, so you can recall any earlier version, see exactly what changed,
who changed it and why, and combine work from many people safely.

**Git** is the most widely used version control system in the world. It was
created in 2005 by Linus Torvalds to manage the Linux kernel, and today nearly
every software project uses it.

---

## 2. Git vs. GitHub (they are not the same thing)

| | Git | GitHub |
|---|-----|--------|
| What is it? | A program you install on your computer | A website that hosts Git repositories |
| Works offline? | Yes, completely | No |
| Made by | The open-source community | A company (owned by Microsoft) |
| Alternatives | (Mercurial, SVN, but Git dominates) | GitLab, Bitbucket, Gitea, Codeberg |

Think of it like this: **Git is the camera, GitHub is the online photo album.**
You take pictures (commits) with Git on your machine, and you can optionally
upload them to GitHub to back them up and share them.

---

## 3. Key ideas in plain English

### Repository ("repo")

A folder whose history Git is tracking. Inside it there is a hidden folder called
`.git` where Git stores the entire history. If you delete `.git`, the folder
becomes a normal folder again and all history is gone (your current files stay).

### Commit

A **snapshot** of your project at a moment in time, plus a message describing it.
A commit is like a save point in a video game. Each commit records:

- the full state of every tracked file (stored efficiently, only differences cost space)
- the author's name and email
- the date and time
- a message ("Fix login button colour")
- a pointer to the **parent** commit (the one before it)

Each commit gets a unique ID called a **hash**, a 40-character string like
`a1b2c3d4e5f6...`. You usually only need the first 7 characters (`a1b2c3d`).

### The three areas (the most important idea in Git)

```
 ┌──────────────────┐   git add    ┌──────────────────┐  git commit  ┌──────────────────┐
 │ Working directory│ ───────────▶ │  Staging area    │ ───────────▶ │   Repository     │
 │ (your files as   │              │  (the "index":   │              │   (.git folder:  │
 │  you edit them)  │ ◀─────────── │  what goes into  │              │   all commits)   │
 └──────────────────┘ git restore  │  the next commit)│              └──────────────────┘
                                   └──────────────────┘
```

1. **Working directory**: the actual files you see and edit in your editor.
2. **Staging area** (also called the **index**): a waiting room. You choose which
   changes go into the next snapshot by "staging" them with `git add`.
3. **Repository**: the permanent history. `git commit` takes everything in the
   staging area and saves it as a new commit.

**Why have a staging area?** Because you often change several things at once but
want to save them as separate, logical commits. Example: you fixed a typo *and*
added a new feature. You can stage and commit the typo fix first ("Fix typo in
README"), then the feature ("Add search bar"). Clean history is much easier to
understand later.

### Branch

A **movable label** that points to a commit. When you make a new commit on a
branch, the label moves forward to it. Branches let you work on something new
(a feature, an experiment) without disturbing the main line of work.

```
            feature:  C ── D
                     /
main:   A ── B ─────E
```

### HEAD

A special pointer that means **"where you are right now"**. Usually it points to
a branch (for example `main`), which in turn points to a commit.

### Remote

A copy of the repository that lives somewhere else, usually on GitHub. By
convention the main remote is called `origin`. You `push` your commits to it and
`pull` other people's commits from it.

### Distributed

Every person who clones a Git repository gets the **entire history** on their own
machine. There is no single point of failure, and you can commit, branch, and
view history with no internet connection.

---

## 4. The life of a file in Git

Every file in your folder is in one of these states:

| State | Meaning |
|-------|---------|
| **Untracked** | Git sees the file but is not tracking it yet (new file, never added). |
| **Unmodified** | Tracked, and identical to the last commit. |
| **Modified** | Tracked, and you changed it since the last commit, but have not staged it. |
| **Staged** | You ran `git add`; the change will go into the next commit. |
| **Ignored** | Listed in `.gitignore`; Git pretends it does not exist. |

`git status` (lesson 2) tells you which state each file is in. You will run it
constantly. That is normal and good.

---

## 5. A typical day with Git

```bash
git pull                     # get the latest work from your team
git switch -c fix-header     # make a branch for your task
# ... edit files in your editor ...
git status                   # see what changed
git add header.html          # stage the change
git commit -m "Fix header alignment on mobile"
git push -u origin fix-header   # upload your branch
# ... open a Pull Request on GitHub, get it reviewed, merge it ...
```

Don't worry if none of that makes sense yet. By lesson 11 every word of it will.

---

## Check your understanding

1. What is the difference between Git and GitHub?
2. Name the three areas a change moves through.
3. What is a commit? What is a hash?
4. What does HEAD mean?
5. Why is the staging area useful?

Answers are in the text above. If you can answer all five, move on to
[Lesson 1: Install and configure](01-install-and-configure.md).
