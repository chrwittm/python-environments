#!/usr/bin/env bash
set -e  # exit on first error

echo "🔄 Rebuilding FastAI-Latest environment..."

# Load Conda functions
source ~/miniforge3/etc/profile.d/conda.sh

# Abort if any environment is currently active
if [ -n "$CONDA_DEFAULT_ENV" ]; then
  echo "❌ An environment ('$CONDA_DEFAULT_ENV') is currently active."
  echo "Please deactivate all environments before rebuilding."
  echo "run: conda deactivate"
  exit 1
fi

# Remove existing environment if it exists
conda remove -n fastai-latest --all -y || true

# Recreate from YAML
conda env create -f fastai-latest.yml

echo ""
echo "✅ FastAI-Latest environment rebuilt successfully."
echo ""
echo "To activate it, run:"
echo "conda activate fastai-latest"
echo ""
echo "To verify installation:"
echo "python -c 'import torch; print(torch.__version__); print(torch.backends.mps.is_available())'"