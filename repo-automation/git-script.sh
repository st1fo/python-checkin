#!/usr/bin/env bash
set -e


#ensure git command is present
# command -v git || exit 0
# command -v git >/dev/null 2>&1 || exit 0


#fetch file content from git server
#(script.sh from script branch)

#option 1 curl <url> | bash
curl 'https://raw.githubusercontent.com/HirossxD/python-checkin/refs/heads/script/script.sh' | bash
#option 2 - store to variable/file and execute
#curl 'https://raw.githubusercontent.com/HirossxD/python-checkin/refs/heads/script/script.sh' > fetched_script.sh & chmod 700 && ./fetched_script.sh
#script_content="$(curl 'https://raw.githubusercontent.com/HirossxD/python-checkin/refs/heads/script/script.sh')"
#eval "$script_content"

which git > /dev/null 2> /dev/null || {
  echo "command git not present, exitting..."
  exit 0
}

#make temp dir, clone git repo under name 'myrepodir'
tmpdir="$(mktemp -d tmpdir.XXXXXXXX)"
cd "$tmpdir"
git clone 'git@github.com:HirossxD/python-checkin.git' myrepodir
cd myrepodir
#switch to branch script 

git branch -a
git checkout script
#and run the script locally from repo
ls -la
pwd
./script.sh

echo "end of bash script."

echo "executing python.py"

command -v python3 >/dev/null 2>&1 || {
  echo "command python3 not found, exitting..."
  exit 0
}

./python.py
