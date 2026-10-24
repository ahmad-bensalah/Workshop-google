#!/usr/bin/env bash
# Builds ./bisect-repo: 30 commits, one of which secretly breaks the calculator (Lab 11).
source "$(dirname "$0")/_common.sh"
new_repo bisect-repo

cat > calculator.sh <<'CALC'
#!/usr/bin/env bash
# Usage: bash calculator.sh add 2 3
op="$1"; a="$2"; b="$3"
case "$op" in
  add) echo $((a + b)) ;;
  mul) echo $((a * b)) ;;
esac
CALC
cat > test.sh <<'TEST'
#!/usr/bin/env bash
# Exits 0 (good) if the calculator works, 1 (bad) otherwise.
if [ "$(bash calculator.sh add 2 3)" = "5" ] && [ "$(bash calculator.sh mul 4 5)" = "20" ]; then
  echo PASS; exit 0
else
  echo FAIL; exit 1
fi
TEST
echo "# Changelog" > CHANGELOG.md
commit "Add calculator and tests"

BAD=$(( (RANDOM % 20) + 6 ))   # the bug lands somewhere in the middle
for i in $(seq 2 30); do
  echo "- change number $i" >> CHANGELOG.md
  if [ "$i" -eq "$BAD" ]; then
    sed -i.bak 's/add) echo $((a + b))/add) echo $((a + b + 0 * 1 - (a > 1)))/' calculator.sh && rm calculator.sh.bak
    commit "Update changelog ($i)"   # sneaky: same message as the others
  else
    commit "Update changelog ($i)"
  fi
done

echo "Created $(pwd) with 30 commits. The latest one fails:"
bash test.sh || true
echo "Next: cd bisect-repo && git bisect start"
