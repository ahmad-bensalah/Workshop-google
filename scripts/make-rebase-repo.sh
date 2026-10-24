#!/usr/bin/env bash
# Builds ./rebase-repo: a feature branch with messy commits behind main (Lab 8).
# Run with the argument "conflict" to make the rebase hit a conflict.
source "$(dirname "$0")/_common.sh"
MODE="${1:-}"
new_repo rebase-repo

printf "<h1>Shop</h1>\n<p>Products</p>\n" > index.html
echo "body { font-family: sans-serif; }" > style.css
commit "Initial shop page"

git switch -q -c feature/search
echo '<input id="search" placeholder="Serach...">' > search.html;   commit "Add search box"
echo '<button>Go</button>' >> search.html;                          commit "WIP"
sed -i.bak 's/Serach/Search/' search.html && rm search.html.bak;    commit "fix typo"
echo "#search { width: 200px; }" >> style.css;                      commit "oops"
echo "<ul id=\"results\"></ul>" > results.html;                     commit "Add search results page"

git switch -q main
echo "<footer>(c) Shop</footer>" >> index.html;                     commit "Add footer"
if [ "$MODE" = "conflict" ]; then
  echo "#search { width: 100%; }" >> style.css;                     commit "Make search full width"
else
  echo "<h1>About us</h1>" > about.html;                            commit "Add about page"
fi

echo "Created $(pwd) (mode: ${MODE:-normal})"
echo "Next: cd rebase-repo && git log --oneline --graph --all"
