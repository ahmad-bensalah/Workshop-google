#!/usr/bin/env bash
# Builds ./history-repo: a small recipe book with a dozen commits to explore (Lab 3).
source "$(dirname "$0")/_common.sh"
new_repo history-repo

echo "# Family Recipes" > README.md;                         commit "Add README"
printf "# Pancakes\n\n- flour\n- milk\n- eggs\n" > pancakes.md; commit "Add pancake recipe"
printf "# Omelette\n\n- eggs\n- butter\n" > omelette.md;      commit "Add omelette recipe"
echo "- sugar" >> pancakes.md;                               commit "Sweeten the pancakes"
sed -i.bak 's/butter/buter/' omelette.md && rm omelette.md.bak; commit "Mention butter brand"
sed -i.bak 's/buter/butter/' omelette.md && rm omelette.md.bak; commit "Fix typo in omelette"
printf "\nRecipes collected by Grandma.\n" >> README.md;     commit "Credit Grandma in README"
printf "# Brownies\n\n- chocolate\n- sugar\n- butter\n" > brownies.md; commit "Add brownies"
echo "- salt" >> omelette.md;                                commit "Season the omelette"
mkdir -p drinks && printf "# Lemonade\n\n- lemons\n- water\n" > drinks/lemonade.md; commit "Add drinks section with lemonade"
echo "- ice" >> drinks/lemonade.md;                          commit "FIX: lemonade needs ice"
git mv brownies.md dessert-brownies.md;                      commit "Rename brownies file"

echo "Created $(pwd) with $(git rev-list --count HEAD) commits."
echo "Next: cd history-repo && git log --oneline"
