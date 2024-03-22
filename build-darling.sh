#!/usr/bin/env bash

set -euxo pipefail

PKGS="$1"

DRV=$(nix-instantiate --option substituters "" -A darwin.Libsystem "$PKGS")

for source in $(nix derivation show "$DRV^*" |jq -r ".\"$DRV\".inputDrvs | keys[]"|grep "source.drv$"); do
  nix-build --check $source
done

