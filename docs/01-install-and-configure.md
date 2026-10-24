# Lesson 1: Install and Configure Git

> **Goal:** have Git installed, know how to open a terminal, and tell Git who you are.

---

## 1. Open a terminal

Git is used mainly from the **terminal** (also called command line, shell, or console).

| System | How to open it |
|--------|----------------|
| Windows | After installing Git (below), open **Git Bash** from the Start menu. (PowerShell also works.) |
| macOS | Press `Cmd + Space`, type **Terminal**, press Enter. |
| Linux | Press `Ctrl + Alt + T`, or search for **Terminal**. |

### Five terminal commands you need (not Git, just the terminal)

| Command | What it does | Example |
|---------|--------------|---------|
| `pwd` | **P**rint **w**orking **d**irectory: shows which folder you are in | `pwd` |
| `ls` | **L**i**s**t files in the current folder (`ls -a` also shows hidden files) | `ls -a` |
| `cd <folder>` | **C**hange **d**irectory: move into a folder. `cd ..` goes up one level, `cd ~` goes home | `cd projects` |
| `mkdir <name>` | **M**a**k**e a new **dir**ectory (folder) | `mkdir git-practice` |
| `echo "text" > file` | Create a file containing "text" (`>>` appends instead of overwriting) | `echo "hello" > notes.txt` |

`cat <file>` prints a file's contents. `clear` clears the screen. Press the
**Up arrow** to recall previous commands, and **Tab** to auto-complete names.

---

## 2. Install Git

### Windows
1. Go to <https://git-scm.com/download/win> and download the installer.
2. Run it. The default options are fine. When asked for the default editor, pick
   one you know (for example **Visual Studio Code** or **Notepad**) instead of Vim
   if you have never used Vim.
3. When asked about the default branch name, choose **"Override… main"**.

### macOS
Run this in Terminal:
```bash
git --version
```
If Git is not installed, macOS offers to install the "Command Line Developer Tools".
Accept. Alternatively, with [Homebrew](https://brew.sh): `brew install git`.

### Linux
```bash
# Debian / Ubuntu
sudo apt update && sudo apt install git

# Fedora
sudo dnf install git

# Arch
sudo pacman -S git
```

### Check it worked
```bash
git --version
```
Output (your version may be newer):
```
git version 2.43.0
```

Any version **2.23 or newer** works for this whole workshop (that version added
`git switch` and `git restore`).

---

## 3. Tell Git who you are: `git config`

Every commit records an author name and email. Set them once:

```bash
git config --global user.name "Ada Lovelace"
git config --global user.email "ada@example.com"
```

- `git config` reads and writes Git settings.
- `--global` means "for every repository on this computer, for my user". Without
  it, the setting only applies to the repository you are currently in.
- Use the **same email as your GitHub account** so GitHub links commits to you.
  If you want to keep your email private, GitHub gives you a no-reply address
  under *Settings → Emails* (it looks like `12345+ada@users.noreply.github.com`).

### Set the default branch name

```bash
git config --global init.defaultBranch main
```

New repositories will start with a branch called `main` (the modern convention)
instead of `master`.

### Set your editor

Some commands (like `git commit` without `-m`) open a text editor for you to write
a message. Choose one you are comfortable with:

```bash
# Visual Studio Code (the --wait flag makes Git wait until you close the tab)
git config --global core.editor "code --wait"

# Nano (simple terminal editor, good for beginners)
git config --global core.editor "nano"

# Notepad on Windows
git config --global core.editor "notepad"
```

> **Stuck in Vim?** If a strange screen appears and you cannot type or exit, you are
> in Vim, the default editor. Press `Esc`, then type `:wq` and press Enter to save
> and quit, or `:q!` and Enter to quit without saving.

### Tell `git pull` how to combine work

```bash
git config --global pull.rebase false
```

Modern Git **refuses** to pull when your branch and GitHub's have both moved on,
until you've told it whether to merge or rebase (lesson 7 explains both). This
setting picks "merge", the simplest choice. Set it now and you'll never see the
`fatal: Need to specify how to reconcile divergent branches` error.

### Nice-to-have settings

```bash
# Colourful output
git config --global color.ui auto

# Line endings (explained in lesson 12)
# On Windows:
git config --global core.autocrlf true
# On macOS / Linux:
git config --global core.autocrlf input
```

### See your settings

```bash
git config --list              # every setting that applies here
git config --global --list     # only your global settings
git config user.name           # read a single setting
git config --list --show-origin  # also show which file each setting comes from
```

### Where settings live

| Level | Flag | File | Applies to |
|-------|------|------|------------|
| System | `--system` | `/etc/gitconfig` | Every user on the machine |
| Global | `--global` | `~/.gitconfig` | Every repo for your user |
| Local | `--local` (default) | `.git/config` inside the repo | Only that repo |

The more specific level wins: local beats global, global beats system. Example:
use your personal email globally, but your work email inside a work repository:

```bash
cd ~/work/company-project
git config user.email "ada@company.com"   # local, only this repo
```

To remove a setting: `git config --global --unset <key>`.

---

## 4. Getting help from Git itself

```bash
git help <command>      # full manual page, e.g. git help commit
git <command> --help    # same thing
git <command> -h        # short summary of options, right in the terminal
```

Press `q` to leave a manual page (they open in a "pager"). Use the arrow keys or
Space to scroll, and `/word` to search.

---

## Summary

| Command | Purpose |
|---------|---------|
| `git --version` | Check Git is installed |
| `git config --global user.name "<name>"` | Set your name for commits |
| `git config --global user.email "<email>"` | Set your email for commits |
| `git config --global init.defaultBranch main` | New repos start on `main` |
| `git config --global core.editor "<editor>"` | Choose the editor Git opens |
| `git config --global pull.rebase false` | Make `git pull` merge when histories diverge |
| `git config --list` | Show all settings |
| `git help <command>` | Read the manual for a command |

**Next:** do [Lab 1](../labs/lab-01-setup.md), then go to
[Lesson 2: Your first repository](02-first-repository.md).
