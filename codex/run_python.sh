#!/usr/bin/env bash
set -e

# No installation, activation in the caller, or rebuilding occurs here.
miniforge_root="${MINIFORGE_ROOT:-$HOME/miniforge3}"
codex_prefix="$miniforge_root/envs/codex"

if [ ! -x "$miniforge_root/bin/conda" ] || \
   [ ! -f "$codex_prefix/conda-meta/history" ] || \
   [ ! -x "$codex_prefix/bin/python" ]; then
  echo "codex is unavailable at $codex_prefix. See codex/README.md for setup or recovery." >&2
  exit 1
fi

# Avoid inheriting Python package paths from an unrelated active environment.
exec env -u PYTHONHOME -u PYTHONPATH PYTHONNOUSERSITE=1 \
  "$miniforge_root/bin/conda" run --no-capture-output \
  --prefix "$codex_prefix" "$codex_prefix/bin/python" "$@"
