# Lesson 10: Tags and Releases

> **Goal:** mark important points in history (like versions) and publish releases.
> Commands: `git tag`, `git push --tags`, `git describe`.

---

## 1. What is a tag?

A tag is a **permanent name for a specific commit**, typically a version like `v1.0.0`.
Unlike a branch, a tag **never moves**.

```
A ── B ── C ── D ── E   ◀── main
          ▲         ▲
        v1.0.0    v1.1.0
```

## 2. Two kinds of tags

| Kind | Command | Stores | Use for |
|------|---------|--------|---------|
| **Annotated** | `git tag -a v1.0.0 -m "First release"` | Tagger name, date, message (a full Git object) | Releases (recommended) |
| **Lightweight** | `git tag v1.0.0` | Just a pointer | Private/temporary bookmarks |

## 3. Tag commands

| Command | Meaning |
|---------|---------|
| `git tag` | List tags |
| `git tag -l "v1.*"` | List tags matching a pattern |
| `git tag -a v1.0.0 -m "<msg>"` | Annotated tag on the current commit |
| `git tag -a v0.9.0 <commit> -m "<msg>"` | Tag an older commit |
| `git show v1.0.0` | Show the tag and its commit |
| `git push origin v1.0.0` | Push one tag (tags are **not** pushed by default!) |
| `git push --tags` | Push all tags |
| `git push --follow-tags` | Push commits plus annotated tags that point to them |
| `git tag -d v1.0.0` | Delete a local tag |
| `git push origin --delete v1.0.0` | Delete a tag on the remote |
| `git switch --detach v1.0.0` | Look at the code as of that version (detached HEAD) |
| `git describe --tags` | Describe the current commit relative to the latest tag, e.g. `v1.0.0-3-g7d2e9f1` (3 commits after v1.0.0) |

## 4. Semantic Versioning (SemVer)

Most projects number versions `MAJOR.MINOR.PATCH`, e.g. `v2.4.1`:

| Bump | When | Example |
|------|------|---------|
| **MAJOR** | Breaking changes: users must change their code | `1.4.2 → 2.0.0` |
| **MINOR** | New features, backwards-compatible | `1.4.2 → 1.5.0` |
| **PATCH** | Bug fixes only | `1.4.2 → 1.4.3` |

See <https://semver.org>.

## 5. GitHub Releases

A **Release** on GitHub is a tag plus release notes and optional downloadable files.

1. Push your tag: `git push origin v1.0.0`
2. On GitHub: **Releases → Draft a new release**, choose the tag, write notes
   (the **Generate release notes** button lists merged pull requests), publish.

Or with the GitHub CLI:
```bash
gh release create v1.0.0 --title "v1.0.0" --generate-notes
```

---

## Summary

| Command | Purpose |
|---------|---------|
| `git tag -a v1.0.0 -m "<msg>"` | Create an annotated tag |
| `git tag` | List tags |
| `git push origin <tag>` / `--tags` | Publish tags |
| `git tag -d <tag>` + `git push origin --delete <tag>` | Delete a tag |
| `git describe --tags` | Where am I relative to the last version? |

**Next:** [Lab 9](../labs/lab-09-stash-tags.md), then
[Lesson 11: Team workflows](11-team-workflows.md).
