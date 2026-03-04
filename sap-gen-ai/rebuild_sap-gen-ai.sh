#!/usr/bin/env bash
set -e  # exit on first error

echo "🔄 Rebuilding SAP Generative AI environment..."

# Source shared safety check
source ../helpers/ensure_no_env.sh

# Remove old environment if it exists
conda remove -n sap-gen-ai --all -y || true

# Recreate from YAML
conda env create -f sap-gen-ai.yml

echo "✅ SAP Generative AI environment rebuilt successfully."
echo ""
echo "To activate it, run:"
echo "conda activate sap-gen-ai"