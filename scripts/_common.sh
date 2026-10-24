#!/usr/bin/env bash
# Shared helpers for the practice-repo scripts. Not meant to be run directly.
set -euo pipefail

# new_repo <folder>: create a fresh repository in <folder> and cd into it.
new_repo() {
  local dir="$1"
  if [ -e "$dir" ]; then
    echo "Folder '$dir' already exists. Delete it or run this script somewhere else." >&2
    exit 1
  fi
  git init -q -b main "$dir"
  cd "$dir"
  # Use your own identity if you configured one (lesson 1), otherwise a placeholder.
  git config user.name  >/dev/null || git config user.name  "Workshop Student"
  git config user.email >/dev/null || git config user.email "student@example.com"
}

# commit <message>: stage everything and commit.
commit() {
  git add -A
  git commit -q -m "$1"
}
