#!/usr/bin/env bash
set -e  # exit on first error

# Resolve paths relative to this script, regardless of the working directory.
rebuild_script_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 Rebuilding FastAI-Latest environment..."

# Source shared safety check
source "$rebuild_script_dir/../helpers/ensure_no_env.sh"

# Remove existing environment if it exists
conda remove -n fastai-latest --all -y || true

# Recreate from YAML
conda env create -f "$rebuild_script_dir/fastai-latest.yml"

echo ""
echo "✅ FastAI-Latest environment rebuilt successfully."
echo ""
echo "To activate it, run:"
echo "conda activate fastai-latest"
echo ""
echo "To verify installation:"
echo "python -c 'import torch; print(torch.__version__); print(torch.backends.mps.is_available())'"
