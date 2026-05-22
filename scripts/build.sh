#! /bin/bash

set -e

MIX_ENV=prod mix deps.get
MIX_ENV=prod mix release --overwrite

tar -czf logexch_prod.tar.gz -C _build/rel/ ./
