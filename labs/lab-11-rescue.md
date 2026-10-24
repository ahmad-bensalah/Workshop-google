# Lab 11: Rescue Missions

**Time:** 45 minutes · **Lesson:** [13](../docs/13-power-tools.md)

## Mission 1: Recover from `reset --hard`

1. In any practice repo, make 3 commits: `A`, `B`, `C` (one file each).
2. `git reset --hard HEAD~3`. The commits are "gone".
3. Use the reflog to bring them all back.

## Mission 2: Resurrect a deleted branch

4. Create `feature/doomed`, commit twice, switch to `main`, `git branch -D feature/doomed`.
5. Recreate the branch exactly as it was.

## Mission 3: Cherry-pick a hotfix

6. On a branch `feature/big`, make 3 commits; the middle one is `Fix critical bug`.
7. Bring only that fix onto `main`, with a reference to the original commit in the message.

## Mission 4: Wrong branch

8. On `main`, commit `Add experimental feature` (oops, it should be on a branch).
9. Move that commit to a new branch `feature/experimental` and remove it from `main`.

## Mission 5: Find the bug with bisect

```bash
cd ~/git-practice
bash <path-to-workshop>/scripts/make-bisect-repo.sh
cd bisect-repo
cat calculator.sh
bash test.sh        # prints PASS or FAIL
```

The repo has 30 commits. The first commit passes the test; the latest fails.

10. Use `git bisect` **manually** to find the first bad commit.
11. Reset, then do it again **automatically** with `git bisect run bash test.sh`.
12. Revert the bad commit on `main` and confirm `bash test.sh` passes.

## Checkpoints

- [ ] Missions 1 and 2: `git log` shows the recovered commits
- [ ] Mission 3: `git log main --oneline` shows `Fix critical bug` but not the other two
- [ ] Mission 5: `bash test.sh` prints `PASS`

Solutions: [solutions.md#lab-11](solutions.md#lab-11)
