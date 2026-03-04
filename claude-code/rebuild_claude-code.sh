#!/usr/bin/env bash
set -e

# Rebuild the claude-code conda environment from scratch
# This script removes the existing environment and recreates it from claude-code.yml

echo "=== Rebuilding claude-code Conda Environment ==="
echo ""

# Safety check: Ensure no conda environment is currently active
# Note: Adjust the path to ensure_no_env.sh if you move this to your python-environments repo
if [ -f "../helpers/ensure_no_env.sh" ]; then
    source ../helpers/ensure_no_env.sh
else
    echo "Warning: ensure_no_env.sh not found. Make sure no conda environment is active."
    if [ -n "$CONDA_DEFAULT_ENV" ] && [ "$CONDA_DEFAULT_ENV" != "base" ]; then
        echo "Error: Conda environment '$CONDA_DEFAULT_ENV' is active. Please deactivate first."
        exit 1
    fi
fi

echo "Removing existing claude-code environment (if it exists)..."
conda remove -n claude-code --all -y || true

echo ""
echo "Creating fresh claude-code environment from claude-code.yml..."
conda env create -f claude-code.yml

echo ""
echo "=== Python Environment Setup Complete ==="
echo ""
echo "To activate: conda activate claude-code"
echo ""
echo "Next steps:"
echo "1. Activate the environment: conda activate claude-code"
echo "2. Install Node.js packages globally:"
echo "   npm install -g docx pptxgenjs"
echo "3. (Optional) Install system tools:"
echo "   brew install --cask libreoffice  # For Excel formula recalculation"
echo "   brew install poppler             # For PDF/image operations"
echo "   brew install pandoc qpdf tesseract  # Additional utilities"
echo ""
