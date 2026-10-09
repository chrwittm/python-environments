#!/usr/bin/env bash
set -e

# Resolve paths relative to this script, regardless of the working directory.
rebuild_script_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 Rebuilding Quarto-blogging environment..."

# Source shared safety check
source "$rebuild_script_dir/../helpers/ensure_no_env.sh"

# Remove existing environment if it exists
conda remove -n quarto-blogging --all -y || true

# Recreate from YAML
conda env create -f "$rebuild_script_dir/quarto-blogging.yml"

echo "✅ Quarto-blogging environment rebuilt successfully."
echo ""
echo "To activate it, run:"
echo "conda activate quarto-blogging"
