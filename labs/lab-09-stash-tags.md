# Lab 9: Stash and Tags

**Time:** 25 minutes · **Lessons:** [09](../docs/09-stash.md), [10](../docs/10-tags-and-releases.md)

## Part A: Stash (in `recipes`)

1. Create a branch `feature/soups` and start editing `README.md` (don't commit).
   Also create a new file `soup.md`.
2. Urgent! Stash **everything including the new file** with the message `soups in progress`.
3. Verify the working tree is clean. Switch to `main`, fix a typo, commit, switch back.
4. List stashes, show the stash's diff, and pop it.
5. Make another change, stash it, and apply it **without** removing it from the stash list.
   Then drop the stash.
6. Bonus: stash a change on `main`, create a new branch with `git stash branch`.

## Part B: Tags

7. Tag the current commit on `main` as `v1.0.0` (annotated, message `First release`).
8. Tag an older commit as `v0.1.0`.
9. List tags, and `git show v1.0.0`.
10. Push both tags to GitHub and look at the **Tags** / **Releases** page.
11. Make one more commit and run `git describe --tags`. Explain the output.
12. Delete `v0.1.0` locally and on GitHub.

## Checkpoints

- [ ] `git stash list` is empty at the end
- [ ] `git tag` shows only `v1.0.0`; GitHub agrees

Solutions: [solutions.md#lab-9](solutions.md#lab-9)
