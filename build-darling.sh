#!/usr/bin/env bash

set -euxo pipefail

PKGS="$1"

DRV=$(nix-instantiate --option substituters "" -A darwin.Libsystem "$PKGS")

for source in $(nix derivation show "$DRV^*" |jq -r ".\"$DRV\".inputDrvs | keys[]"|grep "source.drv$"); do
  if nix derivation show "$source^*"|jq ".\"$source\".env.urls"|grep darling; then
    nix-build --check "$source"
  fi
done

