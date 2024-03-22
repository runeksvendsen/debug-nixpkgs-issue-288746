#!/usr/bin/env bash

set -e

git clone https://github.com/NixOS/nixpkgs.git
cd nixpkgs/

git bisect start
git bisect bad
git bisect bad 380be19fbd2d9079f677978361792cb25e8a3635 # release-22.05
git bisect good 2766f77c32e171a04d59b636a91083bae862274e # release-21.11
git bisect run ../build-darling.sh "$(pwd)"
