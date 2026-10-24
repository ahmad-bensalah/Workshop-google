# Lab 2: First Repository and Commits

**Time:** 30 minutes · **Lesson:** [02](../docs/02-first-repository.md)

You'll build a tiny recipe book.

## Tasks

1. Inside `~/git-practice`, create a folder `recipes` and turn it into a Git repository.
2. Run `git status` and read the output.
3. Create `README.md` containing `# My Recipe Book`. Check the status. Which state is the file in?
4. Stage it and check the status again. Commit it with the message `Add README`.
5. Create two files: `pancakes.md` and `omelette.md` (any content).
6. Commit them in **two separate commits**, one per recipe, with good messages.
7. Add a line to `pancakes.md` **and** a line to `README.md`.
   Use `git status -s` and explain what ` M` means.
8. Stage and commit **only** the README change. Then commit the pancake change.
9. Create `notes.tmp`, stage it by mistake with `git add .`, then **unstage** it
   without deleting it. Then delete the file.
10. Bonus: edit two different places in `omelette.md`, then use `git add -p` to
    commit only the first edit.

## Checkpoints

- [ ] `git log --oneline` shows at least 5 commits with clear messages
- [ ] `git status` says `nothing to commit, working tree clean`
- [ ] `notes.tmp` was never committed (`git log --all -- notes.tmp` prints nothing)

Solutions: [solutions.md#lab-2](solutions.md#lab-2)
