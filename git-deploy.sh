#!/bin/bash
# A simple script to assist in deploying to a master branch.

FAIL=" \033[0;31;49m[==]\033[0m "
GOOD=" \033[0;32;49m[==]\033[0m "
WARN=" \033[0;33;49m[==]\033[0m "
TASK=" \033[0;34;49m[==]\033[0m "
USER=" \033[1;1;49m[==]\033[0m "
SPACE="      "

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
CURRENT_FOLDER=$(pwd)

SOURCE_BRANCH="develop"
DESTINATION_BRANCH="master"

if [ "$CURRENT_BRANCH" != "$SOURCE_BRANCH" ]; then
	printf "$FAIL The current working directory at $CURRENT_FOLDER isn't at the '$SOURCE_BRANCH' branch.\n"
	exit 1
fi

if ! git diff-index --quiet HEAD --; then
	printf "$FAIL The current working directory at $CURRENT_FOLDER has some outstanding changes.\n"
	printf "$USER Please handle all outstanding changes before deploying.\n"
	exit 2
fi

git push -q
if [ "$?" != "0" ]; then
	printf "$FAIL There was an error when pushing the repository.\n"
	printf "$USER Please ensure you can push to the remote before continuing.\n"
	exit 3
fi

printf "$GOOD Repository looks good!\n\n"

printf "This deployment script is designed to push the content from one branch to another.\n"
printf "Usually it's designed to deploy a 'develop' branch to a 'master', quick and simple!\n\n"

printf "$TASK This script will merge '$DESTINATION_BRANCH' with '$SOURCE_BRANCH' without fast-forwarding.\n"
printf "$TASK And then push '$DESTINATION_BRANCH' up to the server.\n"

printf "$USER Do you wish to proceed? [y/N] "
read CONFIRM
printf "\n"
case "$CONFIRM" in
	"y") ;;
	"Y") ;;
	*) printf "$FAIL User declined the deployment.\n"; exit 4 ;;
esac

git pull &&
git checkout $DESTINATION_BRANCH &&
git merge --no-ff $SOURCE_BRANCH -m "Merging develop into master for deployment." &&
git push origin $DESTINATION_BRANCH &&
git checkout $SOURCE_BRANCH

if [ "$?" != "0" ]; then
	printf "$FAIL There was an error whilst deploying the repository :(\n"
	printf "$USER Please check the repository, or run the following by hand:\n"
	printf "$SPACE git pull\n$SPACE git checkout $DESTINATION_BRANCH\n$SPACE git merge --no-ff $SOURCE_BRANCH -m \"Deployment\"\n"
	printf "$SPACE git push origin $DESTINATION_BRANCH\n$SPACE git checkout $SOURCE_BRANCH\n"
	exit 5
fi

exit 0
