#!/usr/bin/env bash
set -e

# Resolve paths relative to this script, regardless of the working directory.
rebuild_script_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Rebuild the claude-code conda environment from scratch
# This script removes the existing environment and recreates it from claude-code.yml

echo "=== Rebuilding claude-code Conda Environment ==="
echo ""

# Source shared safety check
source "$rebuild_script_dir/../helpers/ensure_no_env.sh"

echo "Removing existing claude-code environment (if it exists)..."
conda remove -n claude-code --all -y || true

echo ""
echo "Creating fresh claude-code environment from claude-code.yml..."
conda env create -f "$rebuild_script_dir/claude-code.yml"

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
