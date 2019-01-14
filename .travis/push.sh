#!/bin/sh

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_files() {
  git checkout master
  git add *.html _monthly/ _data/
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER [skip ci]"
}

upload_files() {
  git remote set-url origin https://${GITHUB_TOKEN}@github.com/Kyrremann/allmy.beer.git
  git push
}

setup_git
commit_files
upload_files
