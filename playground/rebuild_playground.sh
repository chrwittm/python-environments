#!/usr/bin/env bash
set -e  # exit on first error

# Resolve paths relative to this script, regardless of the working directory.
rebuild_script_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 Rebuilding Playground environment..."

# Source shared safety check
source "$rebuild_script_dir/../helpers/ensure_no_env.sh"

# Remove old environment if it exists
conda remove -n playground --all -y || true

# Recreate from YAML
conda env create -f "$rebuild_script_dir/playground.yml"

echo "✅ Playground environment rebuilt successfully."
echo ""
echo "To activate it, run:"
echo "conda activate playground"
