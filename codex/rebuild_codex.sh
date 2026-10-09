#!/usr/bin/env bash
set -e

# Deliberate recreation only. Normal Python invocation uses run_python.sh.
if [ "$#" -ne 0 ]; then
  echo "Usage: bash rebuild_codex.sh" >&2
  exit 2
fi

rebuild_script_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
miniforge_root="${MINIFORGE_ROOT:-$HOME/miniforge3}"
codex_prefix="$miniforge_root/envs/codex"

if [ ! -x "$miniforge_root/bin/conda" ]; then
  echo "Miniforge not found at $miniforge_root. Set MINIFORGE_ROOT explicitly." >&2
  exit 1
fi

source "$rebuild_script_dir/../helpers/ensure_no_env.sh"

echo "=== Rebuilding codex Conda Environment ==="
if [ -e "$codex_prefix" ]; then
  # Inspect before removing. Fail on an invalid prefix or removal error.
  echo "Existing environment at $codex_prefix:"
  "$miniforge_root/bin/conda" list --prefix "$codex_prefix"
  "$miniforge_root/bin/conda" env remove --prefix "$codex_prefix" --yes
fi

"$miniforge_root/bin/conda" env create --prefix "$codex_prefix" \
  --file "$rebuild_script_dir/codex.yml" --yes

echo "codex environment ready at $codex_prefix"
echo "Run Python without activation: bash \"$rebuild_script_dir/run_python.sh\" --version"
echo "Optional activation: conda activate \"$codex_prefix\""
