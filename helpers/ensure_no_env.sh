#!/usr/bin/env bash
# -------------------------------------------------------------------
# ensure_no_env.sh
# Abort if any Conda environment is currently active.
# Source this in rebuild scripts before creating/removing environments.
# -------------------------------------------------------------------

# Load Conda commands (if not already available)
source ~/miniforge3/etc/profile.d/conda.sh

if [ -n "$CONDA_DEFAULT_ENV" ]; then
  echo "❌ An environment ('$CONDA_DEFAULT_ENV') is currently active."
  echo "Please deactivate all environments before proceeding."
  echo "run: conda deactivate"
  exit 1
fi