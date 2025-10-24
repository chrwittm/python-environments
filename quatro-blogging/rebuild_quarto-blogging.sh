#!/usr/bin/env bash
set -e

echo "🔄 Rebuilding Quarto-blogging environment..."

# Source shared safety check
source ../helpers/ensure_no_env.sh

# Remove existing environment if it exists
conda remove -n quarto-blogging --all -y || true

# Recreate from YAML
mamba env create -f quarto-blogging.yml

echo "✅ Quarto-blogging environment rebuilt successfully."
echo ""
echo "To activate it, run:"
echo "conda activate quarto-blogging"