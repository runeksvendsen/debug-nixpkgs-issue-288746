#!/usr/bin/env bash

set -euxo pipefail

NIXPKGS="$1"

for drv in $(nix-build --option substituters "" --option store "local?root=$(pwd)/tmp_store" -A darwin.Libsystem "$NIXPKGS" 2>&1 |grep 'source.drv$'); do
  if ! nix derivation show "$drv^*"|jq ".\"$drv\".env.urls"|grep darling; then
    continue
  fi

  nix-build --check "$drv"
done
