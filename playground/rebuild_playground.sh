#!/usr/bin/env bash
set -e  # exit on first error

echo "🔄 Rebuilding Playground environment..."

# Source shared safety check
source ../helpers/ensure_no_env.sh

# Remove old environment if it exists
conda remove -n playground --all -y || true

# Recreate from YAML
mamba env create -f playground.yml

echo "✅ Playground environment rebuilt successfully."
echo ""
echo "To activate it, run:"
echo "conda activate playground"