#IGNORED_FILES=`cat .prettierignore | tr '\n' '|'`
#IGNORED_FILES=`cat .eslintrc | tr '\n' '|'`
IGNORED_FILES=""

echo $(git diff --name-only $(git merge-base origin/master HEAD) --diff-filter=ACMRTUXB |
grep -E "\.(js|jsx|ts|tsx)$" | tr '\n' ' ' | sed -E "s@${IGNORED_FILES}@@g" | xargs) > filestolint.txt

if [ -z $(head -c 1 filestolint.txt) ];
  then echo "There are no files to lint";
  else cli sh yarn eslint --config .eslintrc $(cat filestolint.txt);
fi;

rm filestolint.txt

# Ideally I'd make this support custom args, and not store in filestolint.txt