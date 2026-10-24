#!/usr/bin/env bash
# Builds ./conflict-repo with branches that are guaranteed to conflict with main (Lab 6).
source "$(dirname "$0")/_common.sh"
new_repo conflict-repo

cat > index.html <<'HTML'
<html>
  <body>
    <h1>Welcome to our restaurant</h1>
    <p>Open every day from 9 to 5.</p>
  </body>
</html>
HTML
printf "Menu\n----\nSoup of the day\nPasta\nSalad\nIce cream\n" > menu.txt
commit "Add home page and menu"

# Branch 1: changes the title
git switch -q -c feature/new-title
sed -i.bak 's#<h1>.*</h1>#<h1>Welcome to The Golden Spoon</h1>#' index.html && rm index.html.bak
commit "Use the restaurant's name in the title"

# Branch 2: changes the menu
git switch -q main
git switch -q -c feature/menu
sed -i.bak 's/^Pasta$/Pasta carbonara/; s/^Ice cream$/Chocolate mousse/' menu.txt && rm menu.txt.bak
commit "Update menu with chef's specials"

# Meanwhile on main: the same lines change differently
git switch -q main
sed -i.bak 's#<h1>.*</h1>#<h1>Welcome! Fresh food, friendly prices</h1>#' index.html && rm index.html.bak
sed -i.bak 's/^Pasta$/Pasta bolognese/' menu.txt && rm menu.txt.bak
commit "Make title friendlier and specify pasta"

echo "Created $(pwd)"
echo "Branches: main, feature/new-title, feature/menu (both conflict with main)."
echo "Next: cd conflict-repo && git log --oneline --graph --all"
